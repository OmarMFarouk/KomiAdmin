import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> handleBackgroundMessage(RemoteMessage remoteMessage) async {
  print('title ${remoteMessage.notification!.title}');
  print('body ${remoteMessage.notification!.body}');
  print('payload ${remoteMessage.data}');
}

class PushNotification {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _androidChannel = const AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notifications',
      description: 'important notifications', importance: Importance.max);
  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> initFCM() async {
    await _firebaseMessaging.requestPermission(
        alert: true,
        sound: true,
        badge: true,
        announcement: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true);

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((event) {
      final notification = event.notification;
      if (notification == null) return;
      _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                  importance: Importance.max,
                  priority: Priority.high,
                  _androidChannel.id,
                  _androidChannel.name,
                  channelDescription: _androidChannel.description,
                  icon: '@mipmap/ic_launcher')));
    });
  }
}
