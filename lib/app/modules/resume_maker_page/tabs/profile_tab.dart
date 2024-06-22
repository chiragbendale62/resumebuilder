import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resumebuilderapp/app/models/resume_model.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/resume_maker_controller.dart';
import 'package:resumebuilderapp/app/widgets/custom_text_feild_form.dart';
import 'package:resumebuilderapp/app/widgets/rounded_button.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  var resumeCtrl = Get.find<ResumeMakerController>();
  late TextEditingController _nameController;
  late TextEditingController _designationController;
  late TextEditingController _cityController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _designationController = TextEditingController();
    _cityController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _nameController.text = resumeCtrl.profile != null ? resumeCtrl.profile!.name : '';
    _designationController.text = resumeCtrl.profile != null ? resumeCtrl.profile!.designation : '';
    _cityController.text = resumeCtrl.profile != null ? resumeCtrl.profile!.currentCityAndCountry : '';
    _nameController.addListener(_onNameChange);
    _designationController.addListener(_onDesignationChange);
    _cityController.addListener(_onCityChange);
  }

  void _onNameChange() {
    // final bloc = ResumeMakerBlocProvider.of(context);
    if (_nameController.text.isNotEmpty) {
      resumeCtrl.saveProfileButtonEnable(true);
      resumeCtrl.nextButtonEnable(false);
    }
    // if (resumeCtrl.profile != null && _nameController.text != resumeCtrl.profile!.name) {
    //   resumeCtrl.saveProfileButtonEnable(true);
    //   resumeCtrl.nextButtonEnable(false);
    // }
  }

  void _onDesignationChange() {
    // final bloc = ResumeMakerBlocProvider.of(context);
    if (_designationController.text.isNotEmpty) {
      resumeCtrl.saveProfileButtonEnable(true);
      resumeCtrl.nextButtonEnable(false);
    }
    // if (resumeCtrl.profile != null && _designationController.text != resumeCtrl.profile!.designation) {
    //   resumeCtrl.saveProfileButtonEnable(true);
    //   resumeCtrl.nextButtonEnable(false);
    // }
  }

  void _onCityChange() {
    // final bloc = ResumeMakerBlocProvider.of(context);
    if (_cityController.text.isNotEmpty) {
      resumeCtrl.saveProfileButtonEnable(true);
      resumeCtrl.nextButtonEnable(false);
    }
    // if (resumeCtrl.profile != null && _cityController.text != resumeCtrl.profile!.currentCityAndCountry) {
    //   resumeCtrl.saveProfileButtonEnable(true);
    //   resumeCtrl.nextButtonEnable(false);
    // }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _designationController.dispose();
    _cityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
      child: _buildForm(),
    );
  }

  Widget _buildForm() {
    // final bloc = ResumeMakerBlocProvider.of(context);
    return Obx(
      () => SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: CustomTextFieldForm(
                    controller: _nameController,
                    hintText: 'What is your name?',
                    helperText: 'Your name',
                    validator: (val) => val!.isEmpty
                        ? 'Empty name'
                        : val.length < 2
                            ? 'Invalid name'
                            : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: CustomTextFieldForm(
                    controller: _designationController,
                    hintText: 'What is your designation?',
                    helperText: 'Your designation',
                    validator: (val) => val!.isEmpty
                        ? 'Empty designation'
                        : val.length < 2
                            ? 'Invalid designation'
                            : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: CustomTextFieldForm(
                    controller: _cityController,
                    hintText: 'City, Country (eg: Madrid, Spain)',
                    helperText: 'Your residing city',
                    validator: (val) => val!.isEmpty ? 'Invalid' : null,
                  ),
                ),
                const SizedBox(height: 24),
                RoundedButton(
                  text: 'Save',
                  onPressed: resumeCtrl.saveProfileButtonEnable.value ? _onAddProfile : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onAddProfile() {
    FocusScope.of(context).requestFocus(FocusNode());
    // final bloc = ResumeMakerBlocProvider.of(context);
    if (resumeCtrl.userImage == null) {
      return;
    }
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      resumeCtrl.profile = Profile(
        name: _nameController.text,
        designation: _designationController.text,
        imagePath: resumeCtrl.userImage!.path,
        currentCityAndCountry: _cityController.text,
      );
      resumeCtrl.saveProfileButtonEnable(false);
      resumeCtrl.nextButtonEnable(true);
    }
  }
}
