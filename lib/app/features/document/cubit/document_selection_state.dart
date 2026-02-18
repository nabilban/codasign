import 'package:codasign/core/domain/models/document_model.dart';
import 'package:codasign/core/domain/models/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_selection_state.freezed.dart';

@freezed
class DocumentSelectionState with _$DocumentSelectionState {
  const factory DocumentSelectionState({
    @Default(false) bool isLoading,
    DocumentModel? selectedDocument,
    Failure? failure,
  }) = _DocumentSelectionState;

  factory DocumentSelectionState.initial() => const DocumentSelectionState();
}
