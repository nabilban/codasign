import 'package:codasign/core/domain/models/document_model.dart';
import 'package:codasign/core/domain/models/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'signed_documents_state.freezed.dart';

@freezed
class SignedDocumentsState with _$SignedDocumentsState {
  const factory SignedDocumentsState({
    @Default(true) bool isLoading,
    @Default([]) List<DocumentModel> documents,
    Failure? failure,
  }) = _SignedDocumentsState;

  factory SignedDocumentsState.initial() => const SignedDocumentsState();
}
