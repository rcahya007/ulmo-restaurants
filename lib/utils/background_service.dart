import 'dart:ui';
import 'dart:isolate';

import 'package:ulmo_restaurants/data/api/api_restaurant.dart';
import 'package:ulmo_restaurants/main.dart';
import 'package:ulmo_restaurants/utils/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm fired!');
    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await ApiRestaurant().getRestaurant();
    await notificationHelper.showBigPictureNotification(
      flutterLocalNotificationsPlugin,
      'https://restaurant-api.dicoding.dev/images/small/14',
      'https://restaurant-api.dicoding.dev/images/large/14',
      result,
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
