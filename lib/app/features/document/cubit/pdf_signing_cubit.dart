import 'package:codasign/app/features/document/cubit/pdf_signing_state.dart';
import 'package:codasign/core/domain/models/saved_signature.dart';
import 'package:codasign/core/domain/repositories/document_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PDFSigningCubit extends Cubit<PDFSigningState> {
  PDFSigningCubit({
    required this.repository,
    required PDFSigningState initialState,
  }) : super(initialState);

  final DocumentRepository repository;

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

  Future<void> saveSignedDocument() async {
    if (state.selectedSignature == null) return;

    emit(state.copyWith(isSaving: true, failure: null));

    // Future implementation: Actually merge PDF and Signature image
    // For now, we save the metadata of the signed document
    final doc = state.document.copyWith(
      createdAt: DateTime.now(),
    );

    final result = await repository.saveSignedDocument(doc);

    await Future<void>.delayed(const Duration(seconds: 1));

    result.fold(
      (failure) => emit(state.copyWith(isSaving: false, failure: failure)),
      (_) => emit(state.copyWith(isSaving: false, saveSuccess: true)),
    );
  }
}
