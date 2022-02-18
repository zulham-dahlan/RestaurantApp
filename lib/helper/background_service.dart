

import 'dart:isolate';

import 'dart:ui';

import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/helper/notification_helper.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

final ReceivePort receivePort = ReceivePort();

class BackgroundService {
  static BackgroundService? _service;
  static const String _isolateName = 'isolate';
  static SendPort? _sendPort ;

  BackgroundService._internal(){
    _service = this;
  }

  factory BackgroundService() => _service ?? BackgroundService._internal();

  void initializeIsolate(){
    IsolateNameServer.registerPortWithName(
      receivePort.sendPort,
      _isolateName);
  }

  static Future<void> callback() async {
    print('Alarm Started');
    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await ApiService().listRestaurant(http.Client());
    await _notificationHelper.showNotification(flutterLocalNotificationsPlugin, result);

    _sendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _sendPort?.send(null);
  }
}