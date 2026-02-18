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

      // 1. Calculate ratios
      final widthRatio = pdfPageWidth / viewerPageWidth;
      final heightRatio = pdfPageHeight / viewerPageHeight;

      // 2. Map coordinates to PDF points
      final bakedX = state.signaturePosition.dx * widthRatio;
      final bakedY = state.signaturePosition.dy * heightRatio;

      // Signature base size in UI is 80 (height)
      final bakedHeight = 80 * state.signatureScale * heightRatio;
      final bakedWidth = bakedHeight * 2;

      // 3. Bake signature into PDF
      await mergingService.bakeSignature(
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
