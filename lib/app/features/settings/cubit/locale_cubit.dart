import 'package:bloc/bloc.dart';
import 'package:codasign/app/features/settings/cubit/locale_state.dart';
import 'package:codasign/core/domain/repositories/settings_repository.dart';
import 'package:flutter/material.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit({required SettingsRepository repository})
    : _repository = repository,
      super(LocaleState.initial()) {
    _loadLocale();
  }

  final SettingsRepository _repository;

  Future<void> _loadLocale() async {
    final locale = await _repository.getLocale();
    emit(LocaleState(locale: locale));
  }

  Future<void> setLocale(Locale locale) async {
    if (state.locale == locale) return;

    await _repository.setLocale(locale);
    emit(LocaleState(locale: locale));
  }
}
