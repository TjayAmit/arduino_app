import 'package:arduino_app/Controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:arduino_app/Pages/main_view.dart';
import 'package:get/get.dart';
import 'package:arduino_app/Component/Binding/controllers_bindings.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:arduino_app/Controller/notification_controller.dart';

void main() async {
  runApp(const MyApp());
  NotificationController controller = Get.put(NotificationController());
  await controller.flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(NotificationController.channel);
  Get.put(MainController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arduino App',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const MainView(),
      initialBinding: ControllersBindings(),
      getPages: [GetPage(name: '/', page: () => const MainView())],
    );
  }
}
