import 'package:get/get.dart';
import 'package:resumebuilderapp/app/modules/home_page/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
