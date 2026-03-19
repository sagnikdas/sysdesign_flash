import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_prefs_provider.g.dart';

class UserPrefsState {
  final String displayName;
  final int dailyGoal;
  final ThemeModePreference themeMode;
  final bool remindersEnabled;
  final int reminderHour;
  final int reminderMinute;
  final Set<int> reminderWeekdays;

  const UserPrefsState({
    this.displayName = '',
    this.dailyGoal = 10,
    this.themeMode = ThemeModePreference.system,
    this.remindersEnabled = false,
    this.reminderHour = 20,
    this.reminderMinute = 0,
    this.reminderWeekdays = const {1, 2, 3, 4, 5, 6, 7},
  });

  UserPrefsState copyWith({
    String? displayName,
    int? dailyGoal,
    ThemeModePreference? themeMode,
    bool? remindersEnabled,
    int? reminderHour,
    int? reminderMinute,
    Set<int>? reminderWeekdays,
  }) {
    return UserPrefsState(
      displayName: displayName ?? this.displayName,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      themeMode: themeMode ?? this.themeMode,
      remindersEnabled: remindersEnabled ?? this.remindersEnabled,
      reminderHour: reminderHour ?? this.reminderHour,
      reminderMinute: reminderMinute ?? this.reminderMinute,
      reminderWeekdays: reminderWeekdays ?? this.reminderWeekdays,
    );
  }
}

enum ThemeModePreference { light, dark, system }

@Riverpod(keepAlive: true)
class UserPrefs extends _$UserPrefs {
  late Box<dynamic> _profile;
  late Box<dynamic> _settings;

  @override
  UserPrefsState build() {
    _profile = Hive.box('profile');
    _settings = Hive.box('settings');
    final rawName = _profile.get('name');
    final name = rawName is String ? rawName.trim() : '';
    final rawGoal = _settings.get('dailyGoal');
    final goal = rawGoal is int ? rawGoal : 10;
    final rawThemeMode = _settings.get('themeMode');
    final themeMode = switch (rawThemeMode) {
      'light' => ThemeModePreference.light,
      'dark' => ThemeModePreference.dark,
      _ => ThemeModePreference.system,
    };
    final rawRemindersEnabled = _settings.get('remindersEnabled');
    final remindersEnabled = rawRemindersEnabled is bool
        ? rawRemindersEnabled
        : false;
    final rawReminderHour = _settings.get('reminderHour');
    final reminderHour = rawReminderHour is int && rawReminderHour >= 0
        ? rawReminderHour.clamp(0, 23)
        : 20;
    final rawReminderMinute = _settings.get('reminderMinute');
    final reminderMinute = rawReminderMinute is int && rawReminderMinute >= 0
        ? rawReminderMinute.clamp(0, 59)
        : 0;
    final rawReminderDays = _settings.get('reminderWeekdays');
    final reminderWeekdays = _normalizeWeekdays(rawReminderDays);

    return UserPrefsState(
      displayName: name,
      dailyGoal: goal,
      themeMode: themeMode,
      remindersEnabled: remindersEnabled,
      reminderHour: reminderHour,
      reminderMinute: reminderMinute,
      reminderWeekdays: reminderWeekdays,
    );
  }

  void setDisplayName(String name) {
    final trimmed = name.trim();
    _profile.put('name', trimmed);
    state = state.copyWith(displayName: trimmed);
  }

  void setDailyGoal(int goal) {
    _settings.put('dailyGoal', goal);
    state = state.copyWith(dailyGoal: goal);
  }

  void setThemeMode(ThemeModePreference mode) {
    _settings.put('themeMode', mode.name);
    state = state.copyWith(themeMode: mode);
  }

  void setRemindersEnabled(bool value) {
    _settings.put('remindersEnabled', value);
    state = state.copyWith(remindersEnabled: value);
  }

  void setReminderTime({required int hour, required int minute}) {
    _settings.put('reminderHour', hour);
    _settings.put('reminderMinute', minute);
    state = state.copyWith(reminderHour: hour, reminderMinute: minute);
  }

  void toggleReminderWeekday(int weekday) {
    final days = {...state.reminderWeekdays};
    if (days.contains(weekday)) {
      if (days.length == 1) return;
      days.remove(weekday);
    } else {
      days.add(weekday);
    }
    final normalized = _normalizeWeekdays(days.toList()..sort());
    _settings.put('reminderWeekdays', normalized.toList()..sort());
    state = state.copyWith(reminderWeekdays: normalized);
  }

  void ensureJoinDateRecorded() {
    if (_profile.get('joinDate') == null) {
      _profile.put('joinDate', DateTime.now().toIso8601String());
    }
  }

  Set<int> _normalizeWeekdays(dynamic value) {
    final parsed = <int>{};
    if (value is List) {
      for (final day in value) {
        if (day is int && day >= 1 && day <= 7) {
          parsed.add(day);
        }
      }
    }
    return parsed.isEmpty ? {1, 2, 3, 4, 5, 6, 7} : parsed;
  }
}
