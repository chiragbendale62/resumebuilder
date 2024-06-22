import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resumebuilderapp/app/models/resume_model.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/widgets/onboarding_header_text.dart';
import 'package:resumebuilderapp/app/utils/app_colors.dart';

class ProjectTab extends StatefulWidget {
  const ProjectTab({super.key});

  @override
  _ProjectTabState createState() => _ProjectTabState();
}

class _ProjectTabState extends State<ProjectTab> {
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
              const OnBoardingHeaderText(text: 'Project'),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipOval(
                  child: Container(
                      height: 32,
                      width: 32,
                      color: Theme.of(context).primaryColor,
                      child: IconButton(
                        color: Colors.white,
                        padding: const EdgeInsets.all(4),
                        onPressed: () => _showAddProjectDialog(null, 0),
                        icon: const Icon(Icons.add),
                      )),
                ),
              ),
            ],
          ),
          Expanded(child: _buildProjectList()),
        ],
      ),
    );
  }

  Widget _buildProjectList() {
    var projectList = [];
    // final bloc = ResumeMakerBlocProvider.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: projectList.isEmpty
          ? Container(
              child: const Text('No project added'),
            )
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return _ProjectCard(
                  project: projectList[index],
                  onTap: () => _showAddProjectDialog(
                    projectList[index],
                    index,
                  ),
                );
              },
              itemCount: projectList.length,
            ),
      // child: StreamBuilder<Project>(
      //     stream: bloc.projectListModifiedStream,
      //     builder: (context, snapshot) {
      //       return bloc.projectList.isEmpty
      //           ? Container(
      //               child: const Text('No project added'),
      //             )
      //           : ListView.builder(
      //               itemBuilder: (BuildContext context, int index) {
      //                 return _ProjectCard(
      //                   project: bloc.projectList[index],
      //                   onTap: () => _showAddProjectDialog(
      //                     bloc.projectList[index],
      //                     index,
      //                   ),
      //                 );
      //               },
      //               itemCount: bloc.projectList.length,
      //             );
      //     }),
    );
  }

  Future _showAddProjectDialog(Project? tempProject, int? index) async {
    // Project project = await Navigator.of(context).push(
    //   MaterialPageRoute<Project>(
    //       builder: (BuildContext context) {
    //         return AddProjectDialog(
    //           project: tempProject,
    //         );
    //       },
    //       fullscreenDialog: true),
    // );

    // final bloc = ResumeMakerBlocProvider.of(context);
    // bloc.projectList[index] = project;

    // bloc.projectList.isNotEmpty ? bloc.nextButtonEnableSink.add(true) : bloc.nextButtonEnableSink.add(false);
    // bloc.projectListModifiedSink.add(project);
  }
}

class _ProjectCard extends StatelessWidget {
  final Project project;
  final void Function()? onTap;

  const _ProjectCard({
    required this.project,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(project.toString()),
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
        // bloc.projectList.remove(project);
        // bloc.projectListModifiedSink.add(project);
        // bloc.projectList.isNotEmpty ? bloc.nextButtonEnableSink.add(true) : bloc.nextButtonEnableSink.add(false);
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
                  project != null ? project.projectName : '',
                  style: TextStyle(
                      color: AppColors.black, fontSize: MediaQuery.of(context).size.shortestSide * 0.05, letterSpacing: 0.8),
                  softWrap: true,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  project != null ? project.projectSummary : '',
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
                      '${DateFormat.yMMM().format(project.startDate)} - ',
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: MediaQuery.of(context).size.shortestSide * 0.03,
                          letterSpacing: 0.8),
                      softWrap: true,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      project.endDate.difference(DateTime.now()).inDays == 0
                          ? 'Present'
                          : DateFormat.yMMM().format(project.endDate),
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
