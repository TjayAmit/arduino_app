import 'package:get/get.dart';
import 'package:arduino_app/Controller/main_controller.dart';

class ControllersBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}
