import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resumebuilderapp/app/models/resume_model.dart';
import 'package:resumebuilderapp/app/widgets/custom_text_feild_form.dart';
import 'package:resumebuilderapp/app/widgets/rounded_button.dart';

class AddLanguageDialog extends StatefulWidget {
  final Language language;

  const AddLanguageDialog({super.key, required this.language});

  @override
  _AddLanguageDialogState createState() => _AddLanguageDialogState();
}

class _AddLanguageDialogState extends State<AddLanguageDialog> {
  double level = 0;

  double levelSlider = 0.0;

  late TextEditingController _nameController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.language != null ? widget.language.name : '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildForm(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Add Language',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomTextFieldForm(
                controller: _nameController,
                hintText: 'You speak ...',
                helperText: 'Language name',
                validator: (val) => val!.isEmpty ? 'Empty name' : null,
              ),
              const SizedBox(height: 24.0),
              Slider(
                  label: 'Level',
                  value: level,
                  onChanged: (value) {
                    levelSlider = value;
                    level = value;
                  }),
              Align(
                alignment: Alignment.center,
                child: Text(
                  _getLanguageLevel(level * 100),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24.0),
              RoundedButton(
                text: 'Add',
                onPressed: onAddLanguage,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onAddLanguage() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Get.back(
        result: Language(
          name: _nameController.text,
          level: _getLanguageLevel(level * 100),
        ),
      );
      // Navigator.of(context).pop(
      //   Language(
      //     name: _nameController.text,
      //     level: _getLanguageLevel(level * 100),
      //   ),
      // );
    }
  }

  String _getLanguageLevel(double level) {
    if (level < 25) {
      return 'Beginner Level';
    }

    if (level < 50) {
      return 'Conversational Level';
    }

    if (level < 75) {
      return 'Business Level';
    }

    return 'Fluent Level';
  }
}
