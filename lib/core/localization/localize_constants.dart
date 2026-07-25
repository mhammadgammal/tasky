import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tasky/core/cache/cache_keys.dart';

import '../cache/cache_helper.dart';
import '../di/di.dart';
import 'app_localization.dart';

class LocalizeConstants {
  static const List<String> _locale = ['en', 'ar'];

  static var _defaultLanguage =
      sl<CacheHelper>().getString(key: CacheKeys.currentLanguage) ??
          _getDeviceLanguage();

  // Notifier to notify the app when language changes at runtime.
  // Update this value via `setNewLang` so UI can rebuild.
  static final ValueNotifier<String> currentLanguageNotifier =
      ValueNotifier<String>(_defaultLanguage);

  static const _supportedLocales = [Locale('en'), Locale('ar')];

  static setNewLang(String langCode) {
    _defaultLanguage = langCode;
    try {
      currentLanguageNotifier.value = langCode;
      // persist selection
      sl<CacheHelper>().putString(
        key: CacheKeys.currentLanguage,
        value: langCode,
      );
    } catch (_) {}
  }


  static const List<LocalizationsDelegate> _delegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  //#region Localization Getters
  static List<String> get locale => _locale;

  static String get defaultLanguage => _defaultLanguage;

  static List<Locale> get supportedLocales => _supportedLocales;

  static List<LocalizationsDelegate> get delegates => _delegates;

  //#endregion

  static String _getDeviceLanguage() {
    Locale deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
    log('Locale: ${deviceLocale.languageCode}');
    // Fall back to the first supported locale (English) if the device's
    // language isn't one we ship translations for.
    if (!_locale.contains(deviceLocale.languageCode)) {
      return _locale.first;
    }
    return deviceLocale.languageCode;
  }
}
