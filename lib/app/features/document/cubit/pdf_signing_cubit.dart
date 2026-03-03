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

  void removeSignature() {
    emit(
      state.copyWith(
        selectedSignature: null,
        signaturePosition: const Offset(100, 100),
        signatureScale: 1,
      ),
    );
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

  void setTargetPage(int page) {
    emit(state.copyWith(targetPage: page, currentPage: page));
  }

  void cancelPreview() {
    // Delete the temp preview file if it exists
    if (state.previewPdfPath != null) {
      final file = File(state.previewPdfPath!);
      if (file.existsSync()) {
        file.deleteSync();
      }
    }
    emit(state.copyWith(previewPdfPath: null, isPreviewing: false));
  }

  void updateDocumentName(String name) {
    emit(state.copyWith(document: state.document.copyWith(name: name)));
  }

  Future<void> previewSignedDocument({
    required double pdfPageWidth,
    required double pdfPageHeight,
    required double viewerPageWidth,
    required double viewerPageHeight,
  }) async {
    if (state.selectedSignature == null) return;

    emit(state.copyWith(isPreviewing: true, failure: null));

    try {
      final appDir = await getTemporaryDirectory();
      final tempPath =
          '${appDir.path}/preview_signed_'
          '${DateTime.now().millisecondsSinceEpoch}.pdf';

      final bakeResult = await _computeBakeParams(
        pdfPageWidth: pdfPageWidth,
        pdfPageHeight: pdfPageHeight,
        viewerPageWidth: viewerPageWidth,
        viewerPageHeight: viewerPageHeight,
      );

      await mergingService.bakeSignature(
        inputPath: state.document.path,
        outputPath: tempPath,
        signaturePath: state.selectedSignature!.filePath,
        pageIndex: state.targetPage,
        x: bakeResult.x,
        y: bakeResult.y,
        width: bakeResult.width,
        height: bakeResult.height,
      );

      emit(
        state.copyWith(
          isPreviewing: false,
          previewPdfPath: tempPath,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          isPreviewing: false,
          failure: Failure.database(
            message: 'Failed to generate preview: $e',
          ),
        ),
      );
    }
  }

  Future<void> confirmSave() async {
    if (state.previewPdfPath == null) return;

    emit(state.copyWith(isSaving: true, failure: null));

    try {
      final signedDoc = state.document.copyWith(
        path: state.previewPdfPath!,
        createdAt: DateTime.now(),
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
            message: 'Failed to save document: $e',
          ),
        ),
      );
    }
  }

  Future<_BakeParams> _computeBakeParams({
    required double pdfPageWidth,
    required double pdfPageHeight,
    required double viewerPageWidth,
    required double viewerPageHeight,
  }) async {
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

    // 2. Apply offset for UI padding (8px)
    final uiPaddingOffset = 10 * state.signatureScale * scaleRatio;

    // 3. Map coordinates to PDF points
    final bakedX =
        ((state.signaturePosition.dx - offsetX) * scaleRatio) + uiPaddingOffset;
    final bakedY =
        ((state.signaturePosition.dy - offsetY) * scaleRatio) + uiPaddingOffset;

    // Calculate actual aspect ratio of the signature image
    final signatureFile = File(state.selectedSignature!.filePath);
    final signatureBytes = await signatureFile.readAsBytes();
    final codec = await ui.instantiateImageCodec(signatureBytes);
    final frameInfo = await codec.getNextFrame();
    final imageAspectRatio = frameInfo.image.width / frameInfo.image.height;

    // Signature base size in UI is 80 (height)
    final bakedHeight = 80 * state.signatureScale * scaleRatio;
    final bakedWidth = bakedHeight * imageAspectRatio;

    return _BakeParams(
      x: bakedX,
      y: bakedY,
      width: bakedWidth,
      height: bakedHeight,
    );
  }
}

class _BakeParams {
  const _BakeParams({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  final double x;
  final double y;
  final double width;
  final double height;
}
