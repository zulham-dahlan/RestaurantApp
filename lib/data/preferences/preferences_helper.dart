import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper{
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const DAILY_NOTIFICATION = 'DAILY_NOTIFICATION';

  Future<bool> get isDailyNotificationActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(DAILY_NOTIFICATION) ?? false;
  }

  void setDailyNotification(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DAILY_NOTIFICATION, value);
  }
    
}