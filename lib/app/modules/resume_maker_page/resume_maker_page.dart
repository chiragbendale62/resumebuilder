import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/tabs/all_done_tab.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/tabs/contact_tab.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/tabs/education_tab.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/tabs/experience_tab.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/tabs/language_tab.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/tabs/profile_summary_tab.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/tabs/profile_tab.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/tabs/projects_tab.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/tabs/reference_tab.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/tabs/skills_tab.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/widgets/next_page_button.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/widgets/page_indicator.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/widgets/previous_page_button.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/widgets/user_name_widget.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/widgets/user_picture_widget.dart';

import 'resume_maker_controller.dart';

const _submitAnimationTime = 300;

class ResumeMakerPage extends StatefulWidget {
  const ResumeMakerPage({Key? key}) : super(key: key);

  @override
  State<ResumeMakerPage> createState() => _ResumeMakerPageState();
}

class _ResumeMakerPageState extends State<ResumeMakerPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late PageController _pageController;
  final controller = Get.put(ResumeMakerController());

  Future _navigateToPage(int page) async {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: _submitAnimationTime),
      curve: Curves.linear,
    );
    controller.currentPage.value = page;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: const Duration(seconds: 3),
    )..repeat();
    // controller = ResumeMakerBloc();
    // controller.pageNavigation.listen(_navigateToPage);
    _navigateToPage(controller.pageNavigation.value);
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 1.0,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      // onPopInvoked: _onWillPop,
      child: Scaffold(
        body: Obx(
          () => Stack(
            children: <Widget>[
              _createPager(),
              UserPictureWidget(_animationController),
              const NextPageButton(),
              const PreviousPageButton(),
              const UserNameWidget(),
              Positioned(
                right: 20,
                top: 40,
                child: DotsIndicator(
                  dotsCount: 10,
                  position: controller.pageNavigation.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _createPager() {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollUpdateNotification) {
          controller.mainPager(_pageController.page);
        }
        return true;
      },
      child: PageView(
        onPageChanged: (pos) {
          controller.pageNavigation(pos);
          controller.currentPage.value = pos;
        },
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        controller: _pageController,
        children: const <Widget>[
          ProfileTab(),
          ProfileSummaryTab(),
          ContactTab(),
          EducationTab(),
          ExperienceTab(),
          ProjectTab(),
          SkillTab(),
          ReferenceTab(),
          LanguageTab(),
          AllDoneTab(),
        ],
      ),
    );
  }
}
