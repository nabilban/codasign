import 'package:flutter/material.dart';

abstract class SettingsRepository {
  Future<Locale> getLocale();
  Future<void> setLocale(Locale locale);
}
