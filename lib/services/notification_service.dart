import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  static const int _dailyBaseId = 1000;
  static const int _testNotifId = 9999;

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;
  late tz.Location _location;

  Future<void> initialize() async {
    if (_initialized) return;

    tz.initializeTimeZones();

    // Resolve the device's IANA timezone name so that the TZDateTime we pass
    // to the plugin carries the correct timezone label.  The Java side uses
    // this label to turn the stored local-time string back into an epoch, so
    // it MUST match the device's actual timezone.
    try {
      final tzName = await FlutterTimezone.getLocalTimezone();
      _location = tz.getLocation(tzName);
    } catch (_) {
      // Fallback: scan timezone database for a location whose current UTC
      // offset matches the device's system clock offset.
      _location = _locationFromSystemOffset();
    }

    tz.setLocalLocation(_location);

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwinInit = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    await _plugin.initialize(
      const InitializationSettings(android: androidInit, iOS: darwinInit),
    );
    _initialized = true;
  }

  /// Returns true if notification posting is permitted, false if denied.
  Future<bool> requestPermissions() async {
    await initialize();
    final android = _plugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin
    >();
    final ios = _plugin.resolvePlatformSpecificImplementation<
      IOSFlutterLocalNotificationsPlugin
    >();
    final androidGranted = await android?.requestNotificationsPermission();
    final iosGranted = await ios?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    if (androidGranted == null && iosGranted == null) return true;
    return (androidGranted ?? true) && (iosGranted ?? true);
  }

  /// Fires a notification immediately — used to verify the permission,
  /// channel, and DND settings are all working before relying on scheduling.
  Future<void> showTestNotification() async {
    await initialize();
    await _plugin.show(
      _testNotifId,
      '🔔 Test notification',
      'Notifications are working. Scheduled reminders will appear like this.',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_study_reminders',
          'Daily study reminders',
          channelDescription: 'Daily nudge to keep your study streak going',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }

  Future<void> cancelDailyReminders() async {
    await initialize();
    for (var weekday = 1; weekday <= 7; weekday++) {
      await _plugin.cancel(_dailyBaseId + weekday);
    }
  }

  /// Schedules one repeating notification per selected weekday.
  ///
  /// Each notification uses [matchDateTimeComponents.dayOfWeekAndTime] so it
  /// fires every week on the same day at the same local time without any
  /// app code running.
  Future<void> scheduleWeeklyReminders({
    required int hour,
    required int minute,
    required Set<int> weekdays,
    required String title,
    required String body,
  }) async {
    await initialize();
    await cancelDailyReminders();

    final android = _plugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin
    >();
    final canExact = await android?.canScheduleExactNotifications() ?? true;
    final scheduleMode = canExact
        ? AndroidScheduleMode.exactAllowWhileIdle
        : AndroidScheduleMode.inexact;

    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_study_reminders',
        'Daily study reminders',
        channelDescription: 'Daily nudge to keep your study streak going',
        importance: Importance.high,
        priority: Priority.high,
      ),
    );

    for (final weekday in weekdays) {
      await _plugin.zonedSchedule(
        _dailyBaseId + weekday,
        title,
        body,
        _nextOccurrenceForWeekday(weekday, hour, minute),
        details,
        androidScheduleMode: scheduleMode,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
    }
  }

  /// Returns the next [DateTime] (device local time) at which a reminder
  /// will fire, or null if no weekdays are selected.
  DateTime? nextReminderTime(int hour, int minute, Set<int> weekdays) {
    if (weekdays.isEmpty) return null;
    final now = DateTime.now();
    for (var i = 0; i <= 7; i++) {
      final candidate = DateTime(
        now.year,
        now.month,
        now.day + i,
        hour,
        minute,
      );
      if (candidate.isBefore(now)) continue;
      if (weekdays.contains(candidate.weekday)) return candidate;
    }
    return null;
  }

  // ── private helpers ────────────────────────────────────────────────────────

  /// Builds a [TZDateTime] for the next occurrence of [hour]:[minute] on
  /// [weekday], expressed in [_location] so that the Java plugin stores and
  /// replays the time correctly in the device's local timezone.
  tz.TZDateTime _nextOccurrenceForWeekday(int weekday, int hour, int minute) {
    // Start from the next upcoming hour:minute in the device's local timezone.
    var candidate = _nextOccurrenceAtTime(hour, minute);
    // Advance day-by-day until the weekday matches.
    while (candidate.weekday != weekday) {
      candidate = tz.TZDateTime(
        _location,
        candidate.year,
        candidate.month,
        candidate.day + 1,
        hour,
        minute,
      );
    }
    return candidate;
  }

  /// Returns the next [TZDateTime] (in [_location]) for [hour]:[minute] that
  /// is strictly in the future relative to the device's current wall-clock.
  tz.TZDateTime _nextOccurrenceAtTime(int hour, int minute) {
    // DateTime.now() is always the device's local wall-clock time in Dart —
    // it never depends on the timezone library.
    final now = DateTime.now();
    var t = tz.TZDateTime(_location, now.year, now.month, now.day, hour, minute);
    if (!t.isAfter(tz.TZDateTime.now(_location))) {
      t = tz.TZDateTime(_location, now.year, now.month, now.day + 1, hour, minute);
    }
    return t;
  }

  /// Scans the timezone database for the first location whose current UTC
  /// offset matches the device's system clock offset.  Used when
  /// [FlutterTimezone] is unavailable.
  tz.Location _locationFromSystemOffset() {
    final offset = DateTime.now().timeZoneOffset;
    for (final loc in tz.timeZoneDatabase.locations.values) {
      if (tz.TZDateTime.now(loc).timeZoneOffset == offset) return loc;
    }
    return tz.UTC;
  }
}
