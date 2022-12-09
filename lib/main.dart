import 'package:flutter/material.dart';
import 'package:arduino_app/Pages/main_view.dart';
import 'package:get/get.dart';
import 'package:arduino_app/Component/Binding/controllers_bindings.dart';

void main() {
  runApp(const MyApp());
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
