import 'package:flutter/material.dart';

class L10n {
  static const List<Locale> supportedLocales = [
    Locale('en'), // English
    Locale('ar'), // Arabic
  ];

  static const Locale defaultLocale = Locale('en');

  static String getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'ar':
        return 'العربية';
      default:
        return languageCode;
    }
  }

  static bool isRtl(Locale locale) {
    return locale.languageCode == 'ar';
  }
}
