import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NotificationController extends GetxController {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  var initSettings = const InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/warning'),
  );

  @override
  void onInit() {
    super.onInit();
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onDidReceiveNotificationResponse: (payload) async {
      Get.toNamed('/home');
    });
  }

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title, // description
      importance: Importance.high,
      playSound: true);

  void showNotification(
      int index, String header, String description, String payload) {
    flutterLocalNotificationsPlugin.show(
        index,
        header,
        description,
        payload: payload,
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/warning')));
  }
}
