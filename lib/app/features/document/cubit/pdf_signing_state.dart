import 'package:codasign/core/domain/models/document_model.dart';
import 'package:codasign/core/domain/models/failure.dart';
import 'package:codasign/core/domain/models/saved_signature.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pdf_signing_state.freezed.dart';

@freezed
class PDFSigningState with _$PDFSigningState {
  const factory PDFSigningState({
    required DocumentModel document,
    @Default(false) bool isSaving,
    SavedSignature? selectedSignature,
    @Default(Offset(100, 100)) Offset signaturePosition,
    @Default(1.0) double signatureScale,
    @Default(1) int currentPage,
    Failure? failure,
    @Default(false) bool saveSuccess,
  }) = _PDFSigningState;

  factory PDFSigningState.initial(DocumentModel document) => PDFSigningState(
    document: document,
  );
}
