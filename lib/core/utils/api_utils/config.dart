import 'dart:ui';

import 'api_end_points.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

class Config {
  static const String baseUrl = ApiEndPoints.baseUrl;
  static int? userId;
  final bool syncCallLog =true, showRegister = true, showFieldForce = false;

  //List of locale language code
  List locale = ['en', 'ar', 'de', 'fr', 'es','tr','id','my','be','ch','it'];
  String defaultLanguage = 'en';

  //List of locales included
  List<Locale> supportedLocales = [
    const Locale('en', 'US'),
    const Locale('ar', ''),
    const Locale('de', ''),
    const Locale('fr', ''),
    const Locale('es', ''),
    const Locale('tr', ''),
    const Locale('id', ''),
    const Locale('my', '')
  ];

  //dropdown items for changing language
  List<Map<String, dynamic>> lang = [
    {'languageCode': 'en', 'countryCode': 'US', 'name': 'English'},
    {'languageCode': 'ar', 'countryCode': '', 'name': 'العربي'},
    {'languageCode': 'de', 'countryCode': '', 'name': 'Deutsche'},
    {'languageCode': 'fr', 'countryCode': '', 'name': 'Français'},
    {'languageCode': 'es', 'countryCode': '', 'name': 'Española'},
    {'languageCode': 'tr', 'countryCode': '', 'name': 'Türkçe'},
    {'languageCode': 'id', 'countryCode': '', 'name': 'Indonesian'},
	{'languageCode': 'be', 'countryCode': '', 'name': 'Bengali'},
    {'languageCode': 'ch', 'countryCode': '', 'name': 'chinese'},
    {'languageCode': 'it', 'countryCode': '', 'name': 'italian'},
    {'languageCode': 'my', 'countryCode': '', 'name': 'မြန်မာ'}
  ];

}
