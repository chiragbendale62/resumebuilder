import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:resumebuilderapp/app/models/resume_model.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/resume_maker_controller.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/widgets/onboarding_header_text.dart';
import 'package:resumebuilderapp/app/utils/app_colors.dart';

class ExperienceTab extends StatefulWidget {
  const ExperienceTab({super.key});

  @override
  _ExperienceTabState createState() => _ExperienceTabState();
}

class _ExperienceTabState extends State<ExperienceTab> {
  var resumeCtrl = Get.find<ResumeMakerController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.18),
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const OnBoardingHeaderText(text: 'Experience'),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipOval(
                  child: Container(
                      height: 32,
                      width: 32,
                      color: Theme.of(context).primaryColor,
                      child: IconButton(
                        padding: const EdgeInsets.all(4),
                        color: Colors.white,
                        onPressed: () => _showAddExperienceDialog(null, 0),
                        icon: const Icon(Icons.add),
                      )),
                ),
              ),
            ],
          ),
          Expanded(child: _buildEducationList()),
        ],
      ),
    );
  }

  Widget _buildEducationList() {
    // final bloc = ResumeMakerBlocProvider.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: resumeCtrl.experienceList.isEmpty
          ? Container(
              child: const Text('No experience added'),
            )
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return _ExperienceCard(
                  experience: resumeCtrl.experienceList[index],
                  onTap: () => _showAddExperienceDialog(
                    resumeCtrl.experienceList[index],
                    index,
                  ),
                );
              },
              itemCount: resumeCtrl.experienceList.length,
            ),
    );
  }

  Future _showAddExperienceDialog(Experience? tempExperience, int index) async {
    // Experience experience = await Navigator.of(context).push(
    //   MaterialPageRoute<Experience>(
    //       builder: (BuildContext context) {
    //         return AddExperienceDialog(
    //           experience: tempExperience,
    //         );
    //       },
    //       fullscreenDialog: true),
    // );

    // final bloc = ResumeMakerBlocProvider.of(context);
    // bloc.experienceList[index] = experience;

    // bloc.experienceList.isNotEmpty ? bloc.nextButtonEnableSink.add(true) : bloc.nextButtonEnableSink.add(false);
    // bloc.experienceListModifiedSink.add(experience);
  }
}

class _ExperienceCard extends StatelessWidget {
  final Experience experience;
  final void Function()? onTap;

  const _ExperienceCard({
    required this.experience,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(experience.toString()),
      background: Container(
          padding: const EdgeInsets.only(right: 20.0),
          color: Colors.red,
          child: const Align(
            alignment: Alignment.centerRight,
            child: Text('Delete', textAlign: TextAlign.right, style: TextStyle(color: Colors.white)),
          )),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        // final bloc = ResumeMakerBlocProvider.of(context);
        // bloc.experienceList.remove(experience);
        // bloc.experienceListModifiedSink.add(experience);
        // bloc.experienceList.isNotEmpty ? bloc.nextButtonEnableSink.add(true) : bloc.nextButtonEnableSink.add(false);
      },
      child: _tapableContent(context),
    );
  }

  _tapableContent(BuildContext context) => InkWell(
        onTap: onTap,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  experience != null ? experience.companyName : '',
                  style: TextStyle(
                      color: AppColors.black, fontSize: MediaQuery.of(context).size.shortestSide * 0.05, letterSpacing: 0.8),
                  softWrap: true,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  experience != null ? experience.summary : '',
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: MediaQuery.of(context).size.shortestSide * 0.04,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.8),
                  softWrap: true,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '${DateFormat.yMMM().format(experience.startDate)} - ',
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: MediaQuery.of(context).size.shortestSide * 0.03,
                          letterSpacing: 0.8),
                      softWrap: true,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      experience.endDate.difference(DateTime.now()).inDays == 0
                          ? 'Present'
                          : DateFormat.yMMM().format(experience.endDate),
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: MediaQuery.of(context).size.shortestSide * 0.03,
                          letterSpacing: 0.8),
                      softWrap: true,
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
