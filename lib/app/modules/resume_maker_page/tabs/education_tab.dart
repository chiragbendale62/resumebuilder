import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:resumebuilderapp/app/models/resume_model.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/resume_maker_controller.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/widgets/onboarding_header_text.dart';
import 'package:resumebuilderapp/app/utils/app_colors.dart';

class EducationTab extends StatefulWidget {
  const EducationTab({super.key});

  @override
  _EducationTabState createState() => _EducationTabState();
}

class _EducationTabState extends State<EducationTab> {
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
              const OnBoardingHeaderText(text: 'Education'),
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
                        onPressed: () => _showAddEducationDialog(null, 0),
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
      child: resumeCtrl.educationList.isEmpty
          ? Container(
              child: const Text('No educartion added'),
            )
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return resumeCtrl.educationList[index] != null
                    ? _EducationCard(
                        education: resumeCtrl.educationList[index],
                        onTap: () => _showAddEducationDialog(
                          resumeCtrl.educationList[index],
                          index,
                        ),
                      )
                    : const Offstage();
              },
              itemCount: resumeCtrl.educationList.length,
            ),
    );
  }

  Future _showAddEducationDialog(Education? tempEducation, int index) async {
    //   Education education = await Navigator.of(context).push(
    //     MaterialPageRoute<Education>(
    //         builder: (BuildContext context) {
    //           return AddEducationDialog(
    //             education: tempEducation,
    //           );
    //         },
    //         fullscreenDialog: true),
    //   );

    //   final bloc = ResumeMakerBlocProvider.of(context);
    //   bloc.educationList[index] = education;

    //   bloc.educationList.isNotEmpty ? bloc.nextButtonEnableSink.add(true) : bloc.nextButtonEnableSink.add(false);
    //   bloc.educationListModifiedSink.add(education);
    // }
  }
}

class _EducationCard extends StatelessWidget {
  final Education education;
  final void Function()? onTap;

  const _EducationCard({
    required this.education,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(education.toString()),
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
        // bloc.educationList.remove(education);
        // bloc.educationListModifiedSink.add(education);
        // bloc.educationList.isNotEmpty ? bloc.nextButtonEnableSink.add(true) : bloc.nextButtonEnableSink.add(false);
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
                  education != null ? education.courseTaken : '',
                  style: TextStyle(
                      color: AppColors.black, fontSize: MediaQuery.of(context).size.shortestSide * 0.05, letterSpacing: 0.8),
                  softWrap: true,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  education != null ? education.universityName : '',
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
                      '${DateFormat.yMMM().format(education.startDate)} - ',
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: MediaQuery.of(context).size.shortestSide * 0.03,
                          letterSpacing: 0.8),
                      softWrap: true,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      education.endDate.difference(DateTime.now()).inDays == 0
                          ? 'Present'
                          : DateFormat.yMMM().format(education.endDate),
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
