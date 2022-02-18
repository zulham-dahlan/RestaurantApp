import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/scheduling_notification_provider.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';

class SettingPage extends StatefulWidget {
  static const routeName = '/setting_page';
  static const String settingTitle = 'Setting';
  SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Widget _buildContent() {
    return Consumer<PreferencesProvider>(builder: (context, provider, child) {
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
                  activeTrackColor: Colors.blue,
                );
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: _buildContent(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Settings'),
        transitionBetweenRoutes: false,
      ),
      child: _buildContent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}
