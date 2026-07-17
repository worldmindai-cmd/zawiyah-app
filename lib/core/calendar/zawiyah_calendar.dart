// ============================================================
// Zawiyah — Shia Calendar (ChatGPT-built, adopted after review)
// lib/core/calendar/zawiyah_calendar.dart
//
// Adopted from ChatGPT's version over Claude's own draft: better
// sourced event data (Ashura, Arbaeen, Bibi Sakina's anniversary with
// the Hyderabad note, Wiladat/Shahadat dates, Eid dates) and a more
// standard Kuwaiti-algorithm formula. Manual dayOffset support (added
// by Claude) layers on top since real moon-sighting varies by
// region/marja' and can differ from this tabular calculation.
// ============================================================

class HijriDateValue {
  final int year;
  final int month;
  final int day;
  const HijriDateValue(this.year, this.month, this.day);

  static const _months = [
    'Muharram','Safar','Rabi al-Awwal','Rabi al-Thani',
    'Jumada al-Awwal','Jumada al-Thani','Rajab','Sha\'ban',
    'Ramadhan','Shawwal','Dhu al-Qi\'dah','Dhu al-Hijjah'
  ];

  String get formatted => '$day ${_months[month - 1]} $year AH';
}

class ShiaCalendarContext {
  final DateTime deviceDateTime;
  final HijriDateValue hijri;
  final String eventText;
  final bool isMourning;
  final bool isAyamAza;

  const ShiaCalendarContext({
    required this.deviceDateTime,
    required this.hijri,
    required this.eventText,
    required this.isMourning,
    required this.isAyamAza,
  });
}

class ZawiyahCalendar {
  ZawiyahCalendar._();

  /// [dayOffset] applies a manual adjustment on top of the calculated
  /// date -- since real moon-sighting varies by region/marja' and can
  /// differ from this tabular calculation, users can nudge it by a day.
  static ShiaCalendarContext now({int dayOffset = 0}) =>
      forDate(DateTime.now().add(Duration(days: dayOffset)));

  /// Tabular Hijri conversion used only for contextual display in v1.
  /// A future release should support a user-adjustable local moon-sighting
  /// offset. Prayer times are deliberately outside v1 scope.
  static HijriDateValue toHijri(DateTime localDate) {
    final y = localDate.year;
    final m = localDate.month;
    final d = localDate.day;
    final a = (14 - m) ~/ 12;
    final y2 = y + 4800 - a;
    final m2 = m + 12 * a - 3;
    final jd = d + ((153 * m2 + 2) ~/ 5) + 365 * y2 + y2 ~/ 4 - y2 ~/ 100 + y2 ~/ 400 - 32045;
    final l = jd - 1948440 + 10632;
    final n = (l - 1) ~/ 10631;
    var l2 = l - 10631 * n + 354;
    final j = ((10985 - l2) ~/ 5316) * ((50 * l2) ~/ 17719) + (l2 ~/ 5670) * ((43 * l2) ~/ 15238);
    l2 = l2 - ((30 - j) ~/ 15) * ((17719 * j) ~/ 50) - (j ~/ 16) * ((15238 * j) ~/ 43) + 29;
    final month = (24 * l2) ~/ 709;
    final day = l2 - (709 * month) ~/ 24;
    final year = 30 * n + j - 30;
    return HijriDateValue(year, month, day);
  }

  static ShiaCalendarContext forDate(DateTime localDate) {
    final h = toHijri(localDate);
    final key = '${h.month}-${h.day}';
    final events = <String, String>{
      '1-10': 'Ashura — martyrdom of Imam Hussain (AS) and the martyrs of Karbala',
      '1-19': 'Death anniversary of Bibi Sakina bint Imam Hussain (SA) — observed in Hyderabad, India and other South Asian communities',
      '2-20': 'Arbaeen of Imam Hussain (AS)',
      '3-8': 'Shahadat of Imam Hasan al-Askari (AS); end of Ayam-e-Aza in many communities',
      '3-17': 'Wiladat of the Holy Prophet Muhammad (SAW) and Imam Ja\'far al-Sadiq (AS)',
      '4-10': 'Wafat of Lady Masooma-e-Qom (SA) — observed in Qom and many Shia communities',
      '6-3': 'Shahadat of Lady Fatima al-Zahra (SA)',
      '7-13': 'Wiladat of Imam Ali (AS)',
      '7-25': 'Shahadat of Imam Musa al-Kadhim (AS)',
      '8-15': 'Wiladat of Imam al-Mahdi (AJTF)',
      '9-19': 'Imam Ali (AS) struck while praying; Laylat al-Qadr observance',
      '9-21': 'Shahadat of Imam Ali (AS)',
      '10-1': 'Eid al-Fitr',
      '11-11': 'Wiladat of Imam Ali al-Ridha (AS)',
      '12-10': 'Eid al-Adha',
      '12-18': 'Eid al-Ghadir',
    };
    final isAyamAza = h.month == 1 || h.month == 2 || (h.month == 3 && h.day <= 8);
    const shahadatKeys = {'3-8','6-3','7-25','9-19','9-21'};
    return ShiaCalendarContext(
      deviceDateTime: localDate,
      hijri: h,
      eventText: events[key] ?? 'No major event is currently listed for this date.',
      isAyamAza: isAyamAza,
      isMourning: isAyamAza || shahadatKeys.contains(key),
    );
  }

  static String gregorianLabel(DateTime d) {
    const weekdays = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
    const months = ['January','February','March','April','May','June','July','August','September','October','November','December'];
    return '${weekdays[d.weekday - 1]}, ${d.day} ${months[d.month - 1]} ${d.year}';
  }
}
