import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: (a, b, c, d) => null,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: null,
    );

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: selectNotification,
    );
  }

  setNotification(
    int id, {
    String msg,
    int day,
    int month,
    int year,
  }) async {
    DateTime date1 = DateTime(year, month, day, 9, 0, 0);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      "A Notification From RAKSHA",
      msg,
      // scheduledDate,
      tz.TZDateTime.from(date1, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          '1',
          '12',
          '123',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
    DateTime date2 = DateTime(year, month, day, 21, 0, 0);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id + 1,
      "A Notification From RAKSHA",
      msg,
      // scheduledDate,
      tz.TZDateTime.from(date2, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          '1',
          '12',
          '123',
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future selectNotification(String payload) async {
    //Handle notification tapped logic here
  }
}
