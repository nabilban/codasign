import 'package:bloc/bloc.dart';
import 'package:codasign/app/features/home/cubit/saved_signatures_state.dart';
import 'package:codasign/core/domain/repositories/signature_repository.dart';

class SavedSignaturesCubit extends Cubit<SavedSignaturesState> {
  SavedSignaturesCubit({required this.repository})
    : super(const SavedSignaturesState());

  final SignatureRepository repository;

  Future<void> loadSignatures() async {
    emit(state.copyWith(isLoading: true, failure: null));

    final result = await repository.readSignatures();

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, failure: failure)),
      (signatures) => emit(
        state.copyWith(
          isLoading: false,
          signatures: signatures,
        ),
      ),
    );
  }

  Future<void> deleteSignature(String id) async {
    final result = await repository.removeSignature(id);

    result.fold(
      (failure) => emit(state.copyWith(failure: failure)),
      (_) {
        final updated = state.signatures.where((s) => s.id != id).toList();
        emit(state.copyWith(signatures: updated));
      },
    );
  }
}
