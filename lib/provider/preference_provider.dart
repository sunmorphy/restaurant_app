import 'package:flutter/material.dart';

import '../data/preference/preference_helper.dart';

class PreferenceProvider extends ChangeNotifier {
  PreferenceHelper preferenceHelper;

  PreferenceProvider({required this.preferenceHelper}) {
    _getDailyReminderPref();
    _getUsernamePref();
  }

  bool _isDailyReminderActive = false;
  String _username = "";

  bool get isDailyReminderActive => _isDailyReminderActive;

  String get username => _username;

  void _getDailyReminderPref() async {
    _isDailyReminderActive = await preferenceHelper.isDailyReminderActive;
    notifyListeners();
  }

  void _getUsernamePref() async {
    _username = await preferenceHelper.getUsername;
    notifyListeners();
  }

  void setDailyReminder(bool value) {
    preferenceHelper.setDailyReminder(value);
    _getDailyReminderPref();
  }

  void setUsername(String value) {
    preferenceHelper.setUsername(value);
    _getUsernamePref();
  }
}
