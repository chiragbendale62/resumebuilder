import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:resumebuilderapp/app/models/resume_model.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/resume_maker_controller.dart';
import 'package:resumebuilderapp/app/modules/resume_maker_page/widgets/onboarding_header_text.dart';
import 'package:resumebuilderapp/app/widgets/country_code_picker.dart';
import 'package:resumebuilderapp/app/widgets/custom_text_feild_form.dart';
import 'package:resumebuilderapp/app/widgets/rounded_button.dart';

class ContactTab extends StatefulWidget {
  const ContactTab({super.key});

  @override
  _ContactTabState createState() => _ContactTabState();
}

class _ContactTabState extends State<ContactTab> {
  var resumeCtrl = Get.find<ResumeMakerController>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _linkedController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // final _resumeCtrl = ResumeMakerresumeCtrlProvider.of(context);
    // _emailController.text = _resumeCtrl.contact != null ? _resumeCtrl.contact.email : _emailController.text;
    // _emailController..addListener(_onEmailChange);

    // _phoneController.text = _resumeCtrl.contact != null ? _resumeCtrl.contact.phone : _phoneController.text;
    // _phoneController..addListener(_onPhoneChange);

    // _linkedController.text = _resumeCtrl.contact != null ? _resumeCtrl.contact.linkedin : _linkedController.text;
    // _linkedController..addListener(_onLinkedInChange);

    // _codeController.text = _resumeCtrl.contact != null ? _resumeCtrl.contact.countryCode : _codeController.text;
    // _codeController..addListener(_onCodeChnage);
  }

  void _onEmailChange() {
    // final resumeCtrl = ResumeMakerresumeCtrlProvider.of(context);
    if (resumeCtrl.contact != null && _emailController.text != resumeCtrl.contact!.email) {
      resumeCtrl.enableSaveContactButton(true);
    }
  }

  void _onPhoneChange() {
    // final resumeCtrl = ResumeMakerresumeCtrlProvider.of(context);
    if (resumeCtrl.contact != null && _phoneController.text != resumeCtrl.contact!.phone) {
      resumeCtrl.enableSaveContactButton(true);
    }
  }

  void _onLinkedInChange() {
    // final resumeCtrl = ResumeMakerresumeCtrlProvider.of(context);
    if (resumeCtrl.contact != null && _linkedController.text != resumeCtrl.contact!.linkedin) {
      resumeCtrl.enableSaveContactButton(true);
    }
  }

  void _onCodeChnage() {
    // final resumeCtrl = ResumeMakerresumeCtrlProvider.of(context);
    if (resumeCtrl.contact != null && _codeController.text != resumeCtrl.contact!.countryCode) {
      resumeCtrl.enableSaveContactButton(true);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _linkedController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.18),
      child: _buildForm(),
    );
  }

  Widget _buildForm() {
    // final resumeCtrl = ResumeMakerresumeCtrlProvider.of(context);
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const OnBoardingHeaderText(text: 'Contact'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: CustomTextFieldForm(
                  controller: _emailController,
                  hintText: 'Whats is your email?',
                  helperText: 'Your email',
                  textInputType: TextInputType.emailAddress,
                  validator: (val) {
                    String pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(val!)) {
                      return 'Enter Valid Email';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  InkWell(
                    onTap: _showCountryDialog,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16),
                      child: IgnorePointer(
                        child: SizedBox(
                          width: 75,
                          child: CustomTextFieldForm(
                            controller: _codeController,
                            hintText: '(     )',
                            helperText: 'code',
                            maxLength: 8,
                            textInputType: TextInputType.phone,
                            readOnly: true,
                            validator: (val) => val!.isEmpty ? 'Code' : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                      child: CustomTextFieldForm(
                          controller: _phoneController,
                          hintText: 'Enter mobile digits?',
                          helperText: 'Your mobile number',
                          textInputType: TextInputType.phone,
                          validator: (val) => val!.isEmpty
                              ? 'Empty mobile number'
                              : val.length < 9
                                  ? 'Invalid mobile number'
                                  : null,
                          inputFormatter: [
                            LengthLimitingTextInputFormatter(10),
                          ]),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: CustomTextFieldForm(
                  controller: _linkedController,
                  hintText: 'Enter your LinkedIn profile',
                  helperText: 'Your LinkedIn',
                  validator: (val) => val!.isEmpty ? 'Empty link' : null,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              RoundedButton(
                text: 'Save',
                onPressed: resumeCtrl.contact != null ? _onAddContact : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onAddContact() {
    FocusScope.of(context).requestFocus(FocusNode());
    // final resumeCtrl = ResumeMakerresumeCtrlProvider.of(context);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      resumeCtrl.contact = Contact(
          email: _emailController.text,
          phone: _phoneController.text,
          linkedin: _linkedController.text,
          countryCode: _codeController.text);
      resumeCtrl.enableSaveContactButton(false);
    }
  }

  void _showCountryDialog() {
    showDialog(
      context: context,
      builder: (_) => const SelectionDialog(),
    ).then((e) {
      if (e != null) {
        _codeController.text = e.toString();
      }
    });
  }
}
