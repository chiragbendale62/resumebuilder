import 'package:flutter/material.dart';
import 'package:resumebuilderapp/app/models/resume_model.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/widgets/onboarding_header_text.dart';
import 'package:resumebuilderapp/app/widgets/custom_text_feild_form.dart';

class SkillTab extends StatefulWidget {
  const SkillTab({super.key});

  @override
  _SkillTabState createState() => _SkillTabState();
}

class _SkillTabState extends State<SkillTab> {
  final TextEditingController _skillController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _skillController.addListener(_onTextChange);
  }

  // void _onTextChange() {
  //   final bloc = ResumeMakerBlocProvider.of(context);
  //   bloc.skillIconSink.add(true);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.18),
      child: buildForm(),
    );
  }

  Widget buildForm() {
    // final bloc = ResumeMakerBlocProvider.of(context);
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const OnBoardingHeaderText(text: 'Skills'),
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
                            onPressed: () => _addSkills(),
                            icon: const Icon(Icons.add),

                            // StreamBuilder<bool>(
                            //     stream: bloc.skillIconStream,
                            //     builder: (context, snapshot) {
                            //       IconData iconDate = snapshot.hasData
                            //           ? snapshot.data
                            //               ? Icons.done
                            //               : Icons.add
                            //           : Icons.add;
                            //       return Icon(iconDate);
                            //     }),
                          )),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomTextFieldForm(
                  controller: _skillController,
                  hintText: 'Add Skill ...',
                  helperText: 'Your skill',
                  validator: (val) => val!.isEmpty ? 'Empty skill' : null,
                ),
              ),
              _buildSkillsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillsList() {
    // final bloc = ResumeMakerBlocProvider.of(context);
    List<Education> educationList = [];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: educationList.isEmpty
          ? Container(
              child: const Text('No skill added'),
            )
          : Wrap(
              children: _buildSkillList(
                [
                  // bloc.skillList)
                ],
              ),
            ),
    );
  }

  _buildSkillList(List<String> skillList) {
    List<Widget> skills = [];
    for (var item in skillList) {
      skills.add(Container(
        margin: const EdgeInsets.only(right: 12.0, bottom: 4),
        child: Chip(
          deleteIcon: const Icon(
            Icons.close,
            size: 16,
            color: Colors.white,
          ),
          label: Text(
            item,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.shortestSide * 0.04,
              letterSpacing: 0.8,
              color: Colors.white,
            ),
          ),
          onDeleted: () => _deleteSkills(item),
          elevation: 4,
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ));
    }
    return skills;
  }

  void _addSkills() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // final bloc = ResumeMakerBlocProvider.of(context);
      // bloc.skillList.add(_skillController.text);
      // bloc.skillListModifiedSink.add(_skillController.text);
      // bloc.skillList.isNotEmpty ? bloc.nextButtonEnableSink.add(true) : bloc.nextButtonEnableSink.add(false);
      _skillController.text = '';
      // bloc.skillIconSink.add(false);
    }
  }

  void _deleteSkills(String skill) async {
    FocusScope.of(context).requestFocus(FocusNode());
    // final bloc = ResumeMakerBlocProvider.of(context);
    // bloc.skillList.remove(skill);
    // bloc.skillListModifiedSink.add(skill);
    // bloc.skillList.isNotEmpty ? bloc.nextButtonEnableSink.add(true) : bloc.nextButtonEnableSink.add(false);
  }
}
