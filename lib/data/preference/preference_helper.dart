import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferenceHelper({required this.sharedPreferences});

  static const String dailyReminderPrefs = "DAILY_REMINDER";
  static const String usernamePrefs = "USERNAME";

  Future<bool> get isDailyReminderActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyReminderPrefs) ?? false;
  }

  void setDailyReminder(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyReminderPrefs, value);
  }

  Future<String> get getUsername async {
    final prefs = await sharedPreferences;
    return prefs.getString(usernamePrefs) ?? "";
  }

  void setUsername(String value) async {
    final prefs = await sharedPreferences;
    prefs.setString(usernamePrefs, value);
  }
}
