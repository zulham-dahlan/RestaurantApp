
import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier{
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}){
    _getDailyNotificationPreferences();
  }

  bool _isDailyNotificationActive = false ;
  bool get isDailyNotificationActive => _isDailyNotificationActive;
  
  void _getDailyNotificationPreferences() async {
    _isDailyNotificationActive = await preferencesHelper.isDailyNotificationActive;
    notifyListeners();
  }

  void activateDailyNotification(bool value){
    preferencesHelper.setDailyNotification(value);
    _getDailyNotificationPreferences();
  }
}