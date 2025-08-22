import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotivicationService {
  static final FlutterLocalNotificationsPlugin _natifications =
      FlutterLocalNotificationsPlugin();

  // INIT
  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();

    const setting = InitializationSettings(android: android, iOS: ios);

    await _natifications.initialize(setting);
  }

  // Show
  static Future<void> show({
    required String title,
    required String body,
  }) async {
    const android = AndroidNotificationDetails(
      'main_chennel',
      'Main Channel',
      importance: Importance.max,
      priority: Priority.high,
    );
    const ios = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    const details = NotificationDetails(android: android, iOS: ios);
    await _natifications.show(DateTime.now().microsecond, title, body, details);
  }
}
