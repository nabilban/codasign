import 'package:codasign/core/data/datasources/settings_local_datasource.dart';
import 'package:codasign/core/domain/repositories/settings_repository.dart';
import 'package:flutter/material.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({required SettingsLocalDatasource datasource})
    : _datasource = datasource;

  final SettingsLocalDatasource _datasource;

  @override
  Future<Locale> getLocale() async {
    final code = _datasource.getLanguageCode();
    return Locale(code);
  }

  @override
  Future<void> setLocale(Locale locale) async {
    await _datasource.setLanguageCode(locale.languageCode);
  }
}
