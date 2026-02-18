import 'package:codasign/app/features/home/cubit/signed_documents_state.dart';
import 'package:codasign/core/domain/repositories/document_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignedDocumentsCubit extends Cubit<SignedDocumentsState> {
  SignedDocumentsCubit({required this.repository})
    : super(SignedDocumentsState.initial()) {
    loadDocuments();
  }

  final DocumentRepository repository;

  Future<void> loadDocuments() async {
    emit(state.copyWith(isLoading: true, failure: null));
    final result = await repository.getSavedDocuments();
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, failure: failure)),
      (documents) =>
          emit(state.copyWith(isLoading: false, documents: documents)),
    );
  }

  Future<void> removeDocument(String id) async {
    final result = await repository.deleteDocument(id);
    await result.fold(
      (_) async => null,
      (_) => loadDocuments(),
    );
  }
}
