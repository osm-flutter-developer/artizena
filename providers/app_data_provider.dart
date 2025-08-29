
import 'package:flutter/material.dart';
import 'package:glassify/providers/locales/glassify_locale.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'countries.dart';



class AppDataProvider extends ChangeNotifier {
  final mainNotifier = ValueNotifier(true);


  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  AppDataProvider({
    ThemeMode themeMode = ThemeMode.system,
    GlassifyLocale? locale,
    GlassifyCountry? country,
  }) {
    _themeMode = themeMode;
    _locale = locale;
    _country = country;
  }

  Future<void> changeThemeMode(ThemeMode mode) async {
    if(mode.name == _themeMode.name) return;
    _themeMode = mode;
    notifyListeners();
    final pref = await SharedPreferences.getInstance();
    await pref.setString('theme-mode', mode.name);
    mainNotifier.value = !mainNotifier.value;
  }

  GlassifyCountry? _country = GlassifyCountry.countries.first;
  GlassifyCountry? get country => _country;

  Future<void> changCountry(GlassifyCountry? country, {bool withChangeLocale = true}) async {
    if(country?.countryCode == _country?.countryCode) return;
    _country = country;
    // notifyListeners();
    final pref = await SharedPreferences.getInstance();
    await pref.setString('country-code', country?.countryCode ?? 'null');
    if(withChangeLocale) await changeLocale(GlassifyLocale.supportedLocales.firstWhere((locale) => locale.languageCode == country?.languageCode), enableNotifier: false);
    mainNotifier.value = !mainNotifier.value;
  }

  late GlassifyLocale? _locale;
  GlassifyLocale? get locale => _locale;

  AppLocalization? _appLocalization;
  AppLocalization get localization => _appLocalization ??= locale!.localization;

  Future<void> changeLocale(GlassifyLocale? local, {bool enableNotifier = true}) async {
    if(_locale?.languageCode == local?.languageCode) return;
    _locale = local;
    _appLocalization = local?.localization;
    // notifyListeners();
    final pref = await SharedPreferences.getInstance();
    await pref.setString('language-code', local?.languageCode ?? 'null');
    if(enableNotifier) mainNotifier.value = !mainNotifier.value;
  }

  final AudioPlayer audioPlayer = AudioPlayer();
}


Future<ThemeMode> getThemeMode() async {
  final pref = await SharedPreferences.getInstance();
  final modeType = pref.getString('theme-mode') ?? 'system';
  return ThemeMode.values.firstWhere((type) => type.name == modeType);
}

Future<GlassifyCountry?> getCountry() async {
  final pref = await SharedPreferences.getInstance();
  final countryCode = pref.getString('country-code') ?? '';
  return countryCode.isEmpty || countryCode == 'null'
    ? null
    : GlassifyCountry.countries.firstWhere((type) => type.countryCode == countryCode);
}

Future<GlassifyLocale?> getLocale() async {
  final pref = await SharedPreferences.getInstance();
  final languageCode = pref.getString('language-code') ?? '';
  return languageCode.isEmpty || languageCode == 'null'
      ? null
      : GlassifyLocale.supportedLocales.firstWhere((type) => type.languageCode == languageCode);
}
