import 'package:bloc/bloc.dart';
import 'package:codasign/app/features/signature/cubit/signature_state.dart';
import 'package:flutter/material.dart';

class SignatureCubit extends Cubit<SignatureState> {
  SignatureCubit() : super(const SignatureState());

  void changePenColor(Color color) {
    emit(state.copyWith(penColor: color));
  }

  void changePenThickness(double thickness) {
    emit(state.copyWith(penStrokeWidth: thickness));
  }

  void setDrawing({required bool isDrawing}) {
    emit(state.copyWith(isDrawing: isDrawing));
  }
}
