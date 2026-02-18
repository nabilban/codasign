import 'package:bloc/bloc.dart';
import 'package:codasign/app/features/signature/cubit/signature_state.dart';
import 'package:codasign/core/domain/repositories/signature_repository.dart';
import 'package:flutter/material.dart';

class SignatureCubit extends Cubit<SignatureState> {
  SignatureCubit({required this.repository}) : super(const SignatureState());

  final SignatureRepository repository;

  void changePenColor(Color color) {
    emit(state.copyWith(penColor: color, failure: null, saveSuccess: false));
  }

  void changePenThickness(double thickness) {
    emit(
      state.copyWith(
        penStrokeWidth: thickness,
        failure: null,
        saveSuccess: false,
      ),
    );
  }

  void setDrawing({required bool isDrawing}) {
    emit(state.copyWith(isDrawing: isDrawing));
  }

  Future<void> saveSignature({
    required List<int> bytes,
    required String name,
  }) async {
    emit(state.copyWith(isSaving: true, failure: null, saveSuccess: false));

    final result = await repository.saveSignature(bytes: bytes, name: name);

    result.fold(
      (failure) => emit(state.copyWith(isSaving: false, failure: failure)),
      (_) => emit(state.copyWith(isSaving: false, saveSuccess: true)),
    );
  }
}
