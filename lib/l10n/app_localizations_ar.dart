// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'زاوية';

  @override
  String get appSubtitle =>
      'مكان للتعلّم والعبادة والرفقة من خلال القرآن الكريم وتعاليم أهل البيت عليهم السلام';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navMorningAamal => 'أعمال الصباح';

  @override
  String get navLearn => 'تعلم';

  @override
  String get navTasbeeh => 'التسبيح';

  @override
  String get navKahani => 'القصص';

  @override
  String get navLibrary => 'المكتبة';

  @override
  String get navMore => 'المزيد / المساعدة';

  @override
  String get resetCounters => 'إعادة تعيين العدادات';

  @override
  String get openAll => 'فتح الكل';

  @override
  String get closeAll => 'إغلاق الكل';

  @override
  String get todayLabel => 'اليوم';

  @override
  String get islamicDateLabel => 'التاريخ الهجري';

  @override
  String get shiaCalendarLabel => 'التقويم الشيعي';

  @override
  String get tap => 'اضغط';

  @override
  String get reset => 'إعادة تعيين';
}
