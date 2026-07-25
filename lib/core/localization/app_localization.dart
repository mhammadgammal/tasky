import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'localize_constants.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  Locale locale;

  static AppLocalizations? myAppLocalization;

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Map<String, String>? _localizedStrings;

  Future<void> load() async {
    String jsonString = await rootBundle.loadString(
      'assets/localization/${locale.languageCode}.json',
    );

    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map(
      (key, value) => MapEntry(key, value.toString()),
    );
  }

  String? translate(String key) {
    return _localizedStrings?[key];
  }

  ///
  ///------ must init inside material app
  ///
  ///    MaterialApp(
  ///    builder: (context, child) {
  ///    AppLocalizations.init(context);
  ///
  ///    },
  ///    locale: AppLanguage.appLocal,
  ///    supportedLocales: LocalizeConstants.supportedLocales,
  ///    localizationsDelegates: LocalizeConstants.delegates,
  ///    ));
  ///
  static init(BuildContext context) {
    myAppLocalization ??= AppLocalizations.of(context);
    log(
      'AppLocalizations.init(): myAppLocalization: ${myAppLocalization?.locale.toString()}',
    );
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      LocalizeConstants.locale.contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}

class AppLanguage extends ChangeNotifier {
  static Locale _appLocale = Locale(LocalizeConstants.defaultLanguage);

  static get isArabic => appLocale.languageCode == 'ar';

  static bool get isEnglish => appLocale.languageCode == 'en';

  static Locale get appLocale => _appLocale;

  static TextDirection getTextDirection() {
    if (AppLanguage.isArabic) {
      return TextDirection.rtl;
    } else {
      return TextDirection.ltr;
    }
  }

  static AlignmentGeometry getAlignmentGeometryTopStart() {
    if (AppLanguage.isArabic) {
      return Alignment.topRight;
    } else {
      return Alignment.topLeft;
    }
  }

  static AlignmentGeometry getAlignmentGeometryStartCenter() {
    if (AppLanguage.isArabic) {
      return Alignment.centerRight;
    } else {
      return Alignment.centerLeft;
    }
  }

  static AlignmentGeometry getAlignmentGeometryEndCenter() {
    if (AppLanguage.isArabic) {
      return Alignment.centerLeft;
    } else {
      return Alignment.centerRight;
    }
  }

  static AlignmentGeometry getAlignmentGeometryStart() {
    if (AppLanguage.isArabic) {
      return Alignment.topRight;
    } else {
      return Alignment.topLeft;
    }
  }

  static AlignmentGeometry getAlignmentGeometryEnd() {
    if (AppLanguage.isArabic) {
      return Alignment.topLeft;
    } else {
      return Alignment.topRight;
    }
  }

  static void changeLanguage(String selectedLanguage) async {
    Locale newLocale = Locale(selectedLanguage);
    LocalizeConstants.setNewLang(selectedLanguage);
    _appLocale = Locale(selectedLanguage);
    AppLocalizations.myAppLocalization?.locale = newLocale;
    await AppLocalizations.myAppLocalization?.load();
  }

  static String getNameTwoCharacter() {
    if (isEnglish) return "en";
    if (isArabic) return "ar";
    return "E";
  }

  static String getCurrentName() {
    if (isEnglish) return "E";
    if (isArabic) return "A";
    return "E";
  }
}

extension AppLocationationString on String {
  String tr() {
    return AppLocalizations.myAppLocalization?.translate(this) ?? this;
  }

  /// convert between "english" and "arabic"
  ///   >> example:     'Completed'.ar( "تم التسليم"),
  String ar(String ar) {
    if (AppLanguage.isEnglish) return this;
    return ar;
  }
}

extension ArabicResponsive on AppLanguage {
  static Widget iconArabicToEnglish({
    required BuildContext context,
    required Widget child,
  }) {
    return Transform.rotate(
      angle: AppLanguage.isEnglish ? 3.14 : 0, // 180 degrees
      child: child,
    );
  }

  static Widget iconEnglishToArabic({
    required BuildContext context,
    required Widget child,
  }) {
    return Transform.rotate(
      angle: AppLanguage.isArabic ? 3.14 : 0, // 180 degrees
      child: child,
    );
  }
}
