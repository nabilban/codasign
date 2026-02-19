import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'locale_state.freezed.dart';

@freezed
class LocaleState with _$LocaleState {
  const factory LocaleState({
    required Locale locale,
  }) = _LocaleState;

  factory LocaleState.initial() => const LocaleState(locale: Locale('en'));
}
