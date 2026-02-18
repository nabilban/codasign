import 'package:codasign/app/features/document/cubit/document_selection_state.dart';
import 'package:codasign/core/domain/repositories/document_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocumentSelectionCubit extends Cubit<DocumentSelectionState> {
  DocumentSelectionCubit({required this.repository})
    : super(DocumentSelectionState.initial());

  final DocumentRepository repository;

  Future<void> pickDocument() async {
    emit(state.copyWith(isLoading: true, failure: null));

    final result = await repository.pickDocument();

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, failure: failure)),
      (document) =>
          emit(state.copyWith(isLoading: false, selectedDocument: document)),
    );
  }

  void clearSelection() {
    emit(state.copyWith(selectedDocument: null, failure: null));
  }
}
