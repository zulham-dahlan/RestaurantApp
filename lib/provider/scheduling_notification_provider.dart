import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/helper/background_service.dart';
import 'package:restaurant_app/helper/date_time_schedule.dart';

class SchedulingNotificationProvider extends ChangeNotifier {
  bool _isSchedulingNotification = false;
  bool get isScehdulingNotification => _isSchedulingNotification;

  Future<bool> scheduledNotification(bool value) async {
    _isSchedulingNotification = value;
    if (_isSchedulingNotification) {
      print('Reminder Active');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
          const Duration(hours: 24), 
          1,
          BackgroundService.callback,
          startAt: DateTimeSchedule.formatSchedule(),
          exact: true,
          wakeup: true,
      );
    }else{
      print('Scheduling Reminder Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
