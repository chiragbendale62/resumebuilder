import 'package:get/get.dart';

class PreviewResumeController extends GetxController {
  RxString pathPDF = ''.obs;

  @override
  void onInit() {
    var args = Get.arguments;
    if (args != null) {
      pathPDF(args);
    }
    super.onInit();
  }
}
