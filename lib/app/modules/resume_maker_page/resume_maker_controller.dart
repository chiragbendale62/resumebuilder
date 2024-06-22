import 'dart:io';

import 'package:get/get.dart';
import 'package:resumebuilderapp/app/models/resume_model.dart';
import 'package:resumebuilderapp/app/utils/app_constants.dart';
import 'package:resumebuilderapp/app/utils/create_pdf.dart';

class ResumeMakerController extends GetxController {
  final count = 0.obs;

  RxInt currentPage = NAVIGATE_TO_PROFILE_TAB.obs;
  List<Education> educationList = [];
  List<Experience> experienceList = [];
  List<Project> projectList = [];
  List<Course> courses = [];
  List<String> skillList = [];
  List<Reference> referenceList = [];
  List<Language> languageList = [];
  Profile? profile;
  File? userImage;
  String? profileSummary;
  Contact? contact;

  RxBool nextButtonEnable = false.obs;
  RxBool saveProfileButtonEnable = false.obs;
  RxBool saveContactButtonEnable = false.obs;
  RxBool previewButtonVisibility = false.obs;
  RxBool saveProfileSummaryButtonEnable = false.obs;
  RxInt pageNavigation = 0.obs;
  RxDouble mainPager = 0.0.obs;

  @override
  dispose() {
    // _mainPagerBehaviorSubject.close();
    // _selectedPageBehaviorSubject.close();
    // _errorBehaviorSubject.close();
    // _pictureClickBehaviorSubject.close();
    // _educationListModifiedBehaviorSubject.close();
    // _experienceListModifiedBehaviorSubject.close();
    // _projectListModifiedBehaviorSubject.close();
    // _nextButtonEnableBehaviorSubject.close();
    // _saveProfileButtonEnableBehaviorSubject.close();
    // _saveProfileSummaryButtonEnableBehaviorSubject.close();
    // _saveContactButtonEnableBehaviorSubject.close();
    // _skillListModifiedBehaviorSubject.close();
    // _referenceListModifiedBehaviorSubject.close();
    // _languageListModifiedBehaviorSubject.close();
    // _skillIconBehaviorSubject.close();
    // _previewButtonVisibilityBehaviorSubject.close();
  }

  navigateToNextPageIfPossible() {
    switch (currentPage) {
      case NAVIGATE_TO_PROFILE_TAB:
        {
          currentPage.value = NAVIGATE_TO_PROFILE_SUMMARY_TAB;
          profileSummary != null ? nextButtonEnable(true) : nextButtonEnable(false);

          break;
        }

      case NAVIGATE_TO_PROFILE_SUMMARY_TAB:
        {
          currentPage.value = NAVIGATE_TO_CONTACT_TAB;
          contact != null ? nextButtonEnable(true) : nextButtonEnable(false);
          break;
        }

      case NAVIGATE_TO_CONTACT_TAB:
        {
          currentPage.value = NAVIGATE_TO_EDUCATION_TAB;
          educationList.isNotEmpty ? nextButtonEnable(true) : nextButtonEnable(false);
          break;
        }

      case NAVIGATE_TO_EDUCATION_TAB:
        {
          experienceList.isNotEmpty ? nextButtonEnable(true) : nextButtonEnable(false);
          currentPage.value = NAVIGATE_TO_EXPERIENCE_TAB;
          break;
        }

      case NAVIGATE_TO_EXPERIENCE_TAB:
        {
          projectList.isNotEmpty ? nextButtonEnable(true) : nextButtonEnable(false);
          currentPage.value = NAVIGATE_TO_PROJECTS_TAB;
          break;
        }

      case NAVIGATE_TO_PROJECTS_TAB:
        {
          skillList.isNotEmpty ? nextButtonEnable(true) : nextButtonEnable(false);
          currentPage.value = NAVIGATE_TO_SKILLS_TAB;
          break;
        }

      case NAVIGATE_TO_SKILLS_TAB:
        {
          referenceList.isNotEmpty ? nextButtonEnable(true) : nextButtonEnable(false);
          currentPage.value = NAVIGATE_TO_REFERENCES_TAB;
          break;
        }

      case NAVIGATE_TO_REFERENCES_TAB:
        {
          languageList.isNotEmpty ? nextButtonEnable(true) : nextButtonEnable(false);
          currentPage.value = NAVIGATE_TO_LANGUAGE_TAB;
          break;
        }

      case NAVIGATE_TO_LANGUAGE_TAB:
        {
          currentPage.value = NAVIGATE_TO_ALL_DONE_TAB;
          break;
        }

      case NAVIGATE_TO_ALL_DONE_TAB:
        {
          break;
        }

      default:
        currentPage.value = NAVIGATE_TO_PROFILE_TAB;
    }
    pageNavigation(currentPage.value);
  }

  navigateToPreviousPageIfPossible() {
    nextButtonEnable(true);
    currentPage.value -= 1;
    pageNavigation(currentPage.value);
  }

  enableSaveContactButton(bool isEnable) {
    saveContactButtonEnable(isEnable);
    nextButtonEnable(!isEnable);
  }

  Future createPdf() async {
    Resume resume = Resume(
      profile: profile!,
      profileSummary: profileSummary!,
      contact: contact!,
      educations: educationList,
      experiences: experienceList,
      projects: projectList,
      references: referenceList,
      languages: languageList,
      skills: skillList,
      courses: courses,
    );
    await getPdf(resume);
  }
}
