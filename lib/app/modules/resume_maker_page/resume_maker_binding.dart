import 'package:get/get.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/resume_maker_controller.dart';

class ResumeMakerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResumeMakerController());
  }
}
