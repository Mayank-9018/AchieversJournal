import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Notifications {
  late final tz.Location location;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Notifications() {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('big_logo');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    tz.initializeTimeZones();
    getTimeZone();
  }

  Future<void> getTimeZone() async {
    String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    location = tz.getLocation(timeZone);
  }

  void scheduleNotification(
    int hour,
    int minute,
    int goalId,
    String goalTitle,
    String goalBody,
  ) {
    DateTime now = DateTime.now();
    DateTime notifTime = DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    tz.TZDateTime tzDateTime = tz.TZDateTime.from(notifTime, location);
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'goals-reminders',
      'Goal Reminders',
      channelDescription: 'Notifications for reminding about goals.',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin.zonedSchedule(
      goalId,
      goalTitle,
      goalBody,
      tzDateTime,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
