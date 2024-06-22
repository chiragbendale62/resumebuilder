import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/resume_maker_controller.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/widgets/onboarding_header_text.dart';
import 'package:resumebuilderapp/app/widgets/custom_text_feild_form.dart';
import 'package:resumebuilderapp/app/widgets/rounded_button.dart';

class ProfileSummaryTab extends StatefulWidget {
  const ProfileSummaryTab({super.key});

  @override
  _ProfileSummaryTabState createState() => _ProfileSummaryTabState();
}

class _ProfileSummaryTabState extends State<ProfileSummaryTab> {
  var resumeCtrl = Get.find<ResumeMakerController>();
  late TextEditingController _summaryController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _summaryController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // final _bloc = ResumeMakerBlocProvider.of(context);
    _summaryController.text = resumeCtrl.profileSummary ?? '';
    _summaryController.addListener(_onSummaryChange);
  }

  void _onSummaryChange() {
    // final _bloc = ResumeMakerBlocProvider.of(context);
    if (resumeCtrl.profileSummary != null && _summaryController.text != resumeCtrl.profileSummary) {
      resumeCtrl.saveProfileSummaryButtonEnable(true);
      resumeCtrl.nextButtonEnable(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.18),
      child: buildForm(),
    );
  }

  Widget buildForm() {
    // final _bloc = ResumeMakerBlocProvider.of(context);
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const OnBoardingHeaderText(text: 'Summary'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: CustomTextFieldForm(
                  controller: _summaryController,
                  helperText: 'Write few words about you...',
                  hintText: 'Your summary',
                  maxLines: 10,
                  inputBorder: const OutlineInputBorder(),
                  validator: (val) => val!.isEmpty
                      ? 'Empty summary'
                      : val.length < 2
                          ? 'Invalid summary'
                          : null,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              RoundedButton(
                text: 'Save',
                onPressed: resumeCtrl.saveProfileSummaryButtonEnable.value ? _onAddProfileSummary : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onAddProfileSummary() {
    FocusScope.of(context).requestFocus(FocusNode());
    // final _bloc = ResumeMakerBlocProvider.of(context);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      resumeCtrl.profileSummary = _summaryController.text;
      resumeCtrl.saveProfileSummaryButtonEnable(false);
      resumeCtrl.nextButtonEnable(true);
    }
  }
}
