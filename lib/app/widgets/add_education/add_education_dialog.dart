import 'package:flutter/material.dart';
import 'package:resumebuilderapp/app/models/resume_model.dart';
import 'package:resumebuilderapp/app/widgets/custom_text_feild_form.dart';
import 'package:resumebuilderapp/app/widgets/date_picker_field.dart';
import 'package:resumebuilderapp/app/widgets/rounded_button.dart';

class AddEducationDialog extends StatefulWidget {
  final Education education;

  const AddEducationDialog({super.key, required this.education});

  @override
  _AddEducationDialogState createState() => _AddEducationDialogState();
}

class _AddEducationDialogState extends State<AddEducationDialog> {
  DateTime endDate = DateTime.now();
  DateTime startDate = DateTime.now();

  String error = '';

  late TextEditingController _universityController;
  late TextEditingController _courseController;
  late TextEditingController _linkController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _universityController = TextEditingController(text: widget.education != null ? widget.education.universityName : '');
    _courseController = TextEditingController(text: widget.education != null ? widget.education.courseTaken : '');
    _linkController = TextEditingController(text: widget.education != null ? widget.education.collegeLink : '');

    startDate = widget.education != null ? widget.education.startDate : DateTime.now();
    endDate = widget.education != null ? widget.education.endDate : DateTime.now();
  }

  @override
  void dispose() {
    dispose();
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
          'Add College',
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
                controller: _universityController,
                hintText: 'Name of university ...',
                helperText: 'Your university',
                validator: (val) => val!.isEmpty
                    ? 'Empty name'
                    : val.length < 2
                        ? 'Invalid name'
                        : null,
              ),
              const SizedBox(height: 12.0),
              CustomTextFieldForm(
                controller: _linkController,
                hintText: 'University website',
                helperText: 'University link',
                validator: null,
              ),
              const SizedBox(height: 12.0),
              CustomTextFieldForm(
                controller: _courseController,
                hintText: 'What course you took?',
                helperText: 'Your course',
                validator: (val) => val!.isEmpty ? 'Empty course' : null,
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: DatePicker(
                      labelText: 'Start',
                      errorText: error,
                      dateTime: startDate,
                      onChanged: (dateTime) => startDate = dateTime,
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: DatePicker(
                      labelText: 'End',
                      errorText: error,
                      dateTime: endDate,
                      onChanged: (dateTime) => endDate = dateTime,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              RoundedButton(
                text: 'Add',
                onPressed: onAddEducation,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onAddEducation() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (startDate.isAfter(endDate)) {
        error = 'Invalid date';
        return;
      }

      Navigator.of(context).pop(
        Education(
          collegeLink: _linkController.text,
          startDate: startDate,
          endDate: endDate,
          courseTaken: _courseController.text,
          universityName: _universityController.text,
        ),
      );
    }
  }
}
