import 'dart:async';

import 'package:codasign/app/features/home/cubit/signed_documents_state.dart';
import 'package:codasign/core/domain/models/document_model.dart';
import 'package:codasign/core/domain/repositories/document_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignedDocumentsCubit extends Cubit<SignedDocumentsState> {
  SignedDocumentsCubit({required this.repository})
    : super(SignedDocumentsState.initial()) {
    _subscription = repository.documentsStream().listen((documents) {
      emit(state.copyWith(isLoading: false, documents: documents));
    });
    loadDocuments();
  }

  final DocumentRepository repository;
  StreamSubscription<List<DocumentModel>>? _subscription;

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

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
