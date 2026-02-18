import 'package:codasign/core/domain/models/failure.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'signature_state.freezed.dart';

@freezed
class SignatureState with _$SignatureState {
  const factory SignatureState({
    @Default(Colors.black) Color penColor,
    @Default(3.0) double penStrokeWidth,
    @Default(false) bool isDrawing,
    @Default(false) bool isSaving,
    Failure? failure,
    @Default(false) bool saveSuccess,
  }) = _SignatureState;
}
