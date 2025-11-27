import 'app_localizations.dart';

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'تطبيق الطقس';

  @override
  String get searchCity => 'ابحث عن مدينة...';

  @override
  String get humidity => 'الرطوبة';

  @override
  String get windSpeed => 'سرعة الرياح';

  @override
  String get feelsLike => 'شعور حقيقي';

  @override
  String get settings => 'الإعدادات';

  @override
  String get language => 'اللغة';

  @override
  String get theme => 'المظهر';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get lightMode => 'الوضع الفاتح';

  @override
  String get systemMode => 'الوضع الافتراضي';

  @override
  String get errorNoInternet => 'لا يوجد اتصال بالإنترنت';

  @override
  String get errorGpsDisabled => 'نظام تحديد المواقع معطل';

  @override
  String get errorApiFailure => 'فشل تحميل بيانات الطقس';

  @override
  String get tryAgain => 'حاول مرة أخرى';

  @override
  String get clothingRecommendation => 'توصيات الملابس';

  @override
  String get wearJacket => 'الجو بارد! ارتدِ معطفاً.';

  @override
  String get wearRainCoat => 'إنها تمطر! خذ مظلة أو معطف واق من المطر.';

  @override
  String get wearLight => 'الجو حار! ارتدِ ملابس خفيفة.';

  @override
  String get wearWindbreaker => 'الجو عاصف! سترة واقية من الرياح قد تكون جيدة.';

  @override
  String get wearNormal => 'الطقس لطيف. ملابس عادية مناسبة.';

  @override
  String get weeklyForecast => 'توقعات 7 أيام';

  @override
  String get today => 'اليوم';

  @override
  String get clearSky => 'سماء صافية';

  @override
  String get partlyCloudy => 'غائم جزئياً';

  @override
  String get foggy => 'ضبابي';

  @override
  String get rainy => 'ممطر';

  @override
  String get snowy => 'مثلج';

  @override
  String get heavyRain => 'مطر غزير';

  @override
  String get thunderstorm => 'عاصفة رعدية';

  @override
  String get unknown => 'غير معروف';

  @override
  String get myLocation => 'موقعي';
}
