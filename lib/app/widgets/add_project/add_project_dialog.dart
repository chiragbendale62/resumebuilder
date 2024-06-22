import 'package:flutter/material.dart';
import 'package:resumebuilderapp/app/models/resume_model.dart';
import 'package:resumebuilderapp/app/widgets/custom_text_feild_form.dart';
import 'package:resumebuilderapp/app/widgets/date_picker_field.dart';
import 'package:resumebuilderapp/app/widgets/rounded_button.dart';

class AddProjectDialog extends StatefulWidget {
  final Project project;

  const AddProjectDialog({super.key, required this.project});

  @override
  _AddProjectDialogState createState() => _AddProjectDialogState();
}

class _AddProjectDialogState extends State<AddProjectDialog> {
  DateTime endDate = DateTime.now();
  DateTime startDate = DateTime.now();

  String errorString = '';

  late TextEditingController _nameController;
  late TextEditingController _linkController;
  late TextEditingController _summaryController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.project != null ? widget.project.projectName : '');
    _summaryController = TextEditingController(text: widget.project != null ? widget.project.projectSummary : '');
    _linkController = TextEditingController(text: widget.project != null ? widget.project.projectLink : '');

    startDate = widget.project != null ? widget.project.startDate : DateTime.now();
    endDate = widget.project != null ? widget.project.endDate : DateTime.now();
  }

  @override
  void dispose() {
    dispose();
    _nameController.dispose();
    _summaryController.dispose();
    _linkController.dispose();
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
          'Add Project',
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
                hintText: 'Name of project ...',
                helperText: 'Your project',
                validator: (val) => val!.isEmpty
                    ? 'Empty name'
                    : val.length < 2
                        ? 'Invalid name'
                        : null,
              ),
              const SizedBox(height: 12.0),
              CustomTextFieldForm(
                controller: _linkController,
                hintText: 'Project website',
                helperText: 'Project link',
                validator: null,
              ),
              const SizedBox(height: 12.0),
              CustomTextFieldForm(
                controller: _summaryController,
                hintText: 'What was your contribution?',
                helperText: 'Project summary',
                validator: null,
                maxLines: 10,
                inputBorder: const OutlineInputBorder(),
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
                      errorText: errorString,
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
                      errorText: errorString,
                      dateTime: endDate,
                      onChanged: (dateTime) => endDate = dateTime,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              RoundedButton(
                text: 'Add',
                onPressed: onAddProject,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onAddProject() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (startDate.isAfter(endDate)) {
        errorString = 'Invalid date';
        return;
      }

      Navigator.of(context).pop(
        Project(
          projectLink: _linkController.value.text,
          startDate: startDate,
          endDate: endDate,
          projectName: _nameController.value.text,
          projectSummary: _summaryController.value.text,
        ),
      );
    }
  }
}
