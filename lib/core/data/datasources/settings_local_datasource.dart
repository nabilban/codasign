import 'package:shared_preferences/shared_preferences.dart';

class SettingsLocalDatasource {
  SettingsLocalDatasource({required SharedPreferences prefs}) : _prefs = prefs;

  final SharedPreferences _prefs;

  static const String _localeKey = 'app_locale';

  String getLanguageCode() => _prefs.getString(_localeKey) ?? 'en';

  Future<void> setLanguageCode(String code) async {
    await _prefs.setString(_localeKey, code);
  }
}
