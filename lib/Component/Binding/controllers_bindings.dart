import 'package:get/get.dart';
import 'package:arduino_app/Controller/main_controller.dart';
import 'package:arduino_app/Controller/notification_controller.dart';

class ControllersBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}
