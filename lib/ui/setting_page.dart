import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/scheduling_notification_provider.dart';


class SettingPage extends StatefulWidget {
  static const routeName = '/setting_page';
  static const String settingTitle = 'Setting';
  SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: mainColor),
        centerTitle: true,
        title: Icon(Icons.local_restaurant),
      ),
      body: Consumer<PreferencesProvider>(builder: (context, provider, child) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Scheduling Notification Restaurant'),
              Consumer<SchedulingNotificationProvider>(
                builder: (context, schedule, child) {
                  return Switch.adaptive(
                    value: provider.isDailyNotificationActive,
                    onChanged: (value) async {
                      setState(() {
                        provider.activateDailyNotification(value);
                        schedule.scheduledNotification(value);
                      });
                    },
                    activeColor: Colors.black,
                    activeTrackColor: mainColor,
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
