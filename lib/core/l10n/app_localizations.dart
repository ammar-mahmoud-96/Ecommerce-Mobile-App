import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'Flutter App',
      'home': 'Home',
      'search': 'Search',
      'favorites': 'Favorites',
      'profile': 'Profile',
      'settings': 'Settings',
      'language': 'Language',
      'darkMode': 'Dark Mode',
      'welcome': 'Welcome',
      'login': 'Login',
      'logout': 'Logout',
      'email': 'Email',
      'password': 'Password',
      'submit': 'Submit',
      'cancel': 'Cancel',
      'ok': 'OK',
      'error': 'Error',
      'success': 'Success',
      'loading': 'Loading...',
      'noData': 'No data available',
      'retry': 'Retry',
      'allProducts': 'All Products',
      'cart': 'Cart',
      'splashTitle': 'Welcome to SHOP.CO',
      'getStarted': 'Get Started',
    },
    'ar': {
      'appTitle': 'تطبيق فلاتر',
      'home': 'الرئيسية',
      'search': 'البحث',
      'favorites': 'المفضلة',
      'profile': 'الملف الشخصي',
      'settings': 'الإعدادات',
      'language': 'اللغة',
      'darkMode': 'الوضع الداكن',
      'welcome': 'مرحباً',
      'login': 'تسجيل الدخول',
      'logout': 'تسجيل الخروج',
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'submit': 'إرسال',
      'cancel': 'إلغاء',
      'ok': 'موافق',
      'error': 'خطأ',
      'success': 'نجاح',
      'loading': 'جاري التحميل...',
      'noData': 'لا توجد بيانات',
      'retry': 'إعادة المحاولة',
      'allProducts': 'جميع المنتجات',
      'cart': 'السلة',
      'splashTitle': 'مرحباً بك في SHOP.CO',
      'getStarted': 'ابدأ الآن',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  // Use translate(key) directly from widgets:
  // AppLocalizations.of(context)?.translate('yourKey') ?? 'fallback'

  // Getters for common strings (convenience methods)
  String get appTitle => translate('appTitle');
  String get home => translate('home');
  String get search => translate('search');
  String get favorites => translate('favorites');
  String get profile => translate('profile');
  String get settings => translate('settings');
  String get language => translate('language');
  String get darkMode => translate('darkMode');
  String get welcome => translate('welcome');
  String get login => translate('login');
  String get logout => translate('logout');
  String get email => translate('email');
  String get password => translate('password');
  String get submit => translate('submit');
  String get cancel => translate('cancel');
  String get ok => translate('ok');
  String get error => translate('error');
  String get success => translate('success');
  String get loading => translate('loading');
  String get noData => translate('noData');
  String get retry => translate('retry');
  String get cart => translate('cart');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
