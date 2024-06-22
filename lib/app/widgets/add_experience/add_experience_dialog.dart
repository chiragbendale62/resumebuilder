import 'package:flutter/material.dart';
import 'package:resumebuilderapp/app/models/resume_model.dart';
import 'package:resumebuilderapp/app/widgets/custom_text_feild_form.dart';
import 'package:resumebuilderapp/app/widgets/date_picker_field.dart';
import 'package:resumebuilderapp/app/widgets/rounded_button.dart';

class AddExperienceDialog extends StatefulWidget {
  final Experience experience;

  const AddExperienceDialog({super.key, required this.experience});

  @override
  _AddExperienceDialogState createState() => _AddExperienceDialogState();
}

class _AddExperienceDialogState extends State<AddExperienceDialog> {
  DateTime endDate = DateTime.now();
  DateTime startDate = DateTime.now();

  String error = '';

  late TextEditingController _nameController;

  late TextEditingController _designationController;

  late TextEditingController _linkController;

  late TextEditingController _summaryController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.experience != null ? widget.experience.companyName : '');
    _designationController = TextEditingController(text: widget.experience != null ? widget.experience.designation : '');
    _linkController = TextEditingController(text: widget.experience != null ? widget.experience.companyLink : '');
    _summaryController = TextEditingController(text: widget.experience != null ? widget.experience.summary : '');
    startDate = widget.experience != null ? widget.experience.startDate : DateTime.now();
    endDate = widget.experience != null ? widget.experience.endDate : DateTime.now();
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
          'Add Experience',
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
                hintText: 'Name of company ...',
                helperText: 'Your company',
                validator: (val) => val!.isEmpty
                    ? 'Empty name'
                    : val.length < 2
                        ? 'Invalid name'
                        : null,
              ),
              const SizedBox(height: 16.0),
              CustomTextFieldForm(
                controller: _linkController,
                hintText: 'Company website',
                helperText: 'Company link',
                validator: null,
              ),
              const SizedBox(height: 16.0),
              CustomTextFieldForm(
                controller: _designationController,
                hintText: 'What was your role?',
                helperText: 'Your designation',
                validator: (val) => val!.isEmpty
                    ? 'Empty designation'
                    : val.length < 2
                        ? 'Invalid designation'
                        : null,
              ),
              const SizedBox(height: 16.0),
              CustomTextFieldForm(
                controller: _summaryController,
                hintText: 'What was your contribution?',
                helperText: 'Job summary',
                validator: null,
                maxLines: 10,
                inputBorder: const OutlineInputBorder(),
              ),
              const SizedBox(height: 16.0),
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
                onPressed: onAddExperience,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onAddExperience() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (startDate.isAfter(endDate)) {
        error = 'Invalid date';
        return;
      }

      Navigator.of(context).pop(
        Experience(
          companyLink: _linkController.value.text,
          startDate: startDate,
          endDate: endDate,
          designation: _designationController.value.text,
          companyName: _nameController.value.text,
          summary: _summaryController.value.text,
        ),
      );
    }
  }
}
