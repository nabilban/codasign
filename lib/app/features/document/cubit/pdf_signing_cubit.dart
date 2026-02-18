import 'dart:io';
import 'dart:ui' as ui;
import 'package:codasign/app/features/document/cubit/pdf_signing_state.dart';
import 'package:codasign/core/data/services/pdf_merging_service.dart';
import 'package:codasign/core/domain/models/failure.dart';
import 'package:codasign/core/domain/models/saved_signature.dart';
import 'package:codasign/core/domain/repositories/document_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

class PDFSigningCubit extends Cubit<PDFSigningState> {
  PDFSigningCubit({
    required this.repository,
    required this.mergingService,
    required PDFSigningState initialState,
  }) : super(initialState);

  final DocumentRepository repository;
  final PdfMergingService mergingService;

  void selectSignature(SavedSignature signature) {
    emit(state.copyWith(selectedSignature: signature));
  }

  void updatePosition(Offset position) {
    emit(state.copyWith(signaturePosition: position));
  }

  void updateScale(double scale) {
    emit(state.copyWith(signatureScale: scale));
  }

  void updatePage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  Future<void> saveSignedDocument({
    required double pdfPageWidth,
    required double pdfPageHeight,
    required double viewerPageWidth,
    required double viewerPageHeight,
  }) async {
    if (state.selectedSignature == null) return;

    emit(state.copyWith(isSaving: true, failure: null));

    try {
      final appDir = await getTemporaryDirectory();
      final tempPath =
          '${appDir.path}/temp_signed_'
          '${DateTime.now().millisecondsSinceEpoch}.pdf';

      // 1. Calculate ratios and offsets
      final pdfAspectRatio = pdfPageWidth / pdfPageHeight;
      final viewerAspectRatio = viewerPageWidth / viewerPageHeight;

      double renderedWidth;
      double renderedHeight;
      double offsetX = 0;
      double offsetY = 0;

      if (viewerAspectRatio > pdfAspectRatio) {
        // Viewer is wider than PDF (Fit Height)
        renderedHeight = viewerPageHeight;
        renderedWidth = renderedHeight * pdfAspectRatio;
        offsetX = (viewerPageWidth - renderedWidth) / 2;
      } else {
        // Viewer is narrower than PDF (Fit Width) - Common for mobile
        renderedWidth = viewerPageWidth;
        renderedHeight = renderedWidth / pdfAspectRatio;
        offsetY = (viewerPageHeight - renderedHeight) / 2;
      }

      final scaleRatio = pdfPageWidth / renderedWidth;

      // 3. Apply offset for UI padding (8px)
      // The user places the container, but the image is padded inside by 8px.
      // We need to shift the baked position to match the image's visual location.
      final uiPaddingOffset = 8 * state.signatureScale * scaleRatio;

      // 4. Map coordinates to PDF points using calculated scale and offsets
      final bakedX =
          ((state.signaturePosition.dx - offsetX) * scaleRatio) +
          uiPaddingOffset;
      final bakedY =
          ((state.signaturePosition.dy - offsetY) * scaleRatio) +
          uiPaddingOffset;

      // Calculate actual aspect ratio of the signature image
      final signatureFile = File(state.selectedSignature!.filePath);
      final signatureBytes = await signatureFile.readAsBytes();
      final codec = await ui.instantiateImageCodec(signatureBytes);
      final frameInfo = await codec.getNextFrame();
      final imageAspectRatio = frameInfo.image.width / frameInfo.image.height;

      // Signature base size in UI is 80 (height)
      final bakedHeight = 80 * state.signatureScale * scaleRatio;
      final bakedWidth = bakedHeight * imageAspectRatio;

      // 3. Bake signature into PDF and get page count
      final pageCount = await mergingService.bakeSignature(
        inputPath: state.document.path,
        outputPath: tempPath,
        signaturePath: state.selectedSignature!.filePath,
        pageIndex: state.currentPage,
        x: bakedX,
        y: bakedY,
        width: bakedWidth,
        height: bakedHeight,
      );

      // 4. Update document metadata and save to repository
      final signedDoc = state.document.copyWith(
        path: tempPath,
        createdAt: DateTime.now(),
        pageCount: pageCount,
      );

      final result = await repository.saveSignedDocument(signedDoc);

      result.fold(
        (failure) => emit(state.copyWith(isSaving: false, failure: failure)),
        (_) => emit(state.copyWith(isSaving: false, saveSuccess: true)),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          isSaving: false,
          failure: Failure.database(
            message: 'Failed to bake signature: $e',
          ),
        ),
      );
    }
  }
}
