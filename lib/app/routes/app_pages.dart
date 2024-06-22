import 'package:get/get.dart';
import 'package:resumebuilderapp/app/modules/home_page/home_binding.dart';
import 'package:resumebuilderapp/app/modules/home_page/home_page.dart';
import 'package:resumebuilderapp/app/modules/preview_resume_page/preview_resume_binding.dart';
import 'package:resumebuilderapp/app/modules/preview_resume_page/preview_resume_page.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/resume_maker_binding.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/resume_maker_page.dart';
import 'package:resumebuilderapp/app/routes/app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.resumeMakerPage,
      page: () => const ResumeMakerPage(),
      binding: ResumeMakerBinding(),
    ),
    GetPage(
      name: AppRoutes.previewResumePage,
      page: () => PreviewResumePage(),
      binding: PreviewResumeBinding(),
    ),
  ];
}
