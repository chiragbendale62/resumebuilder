import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resumebuilderapp/app/models/resume_model.dart';
import 'package:resumebuilderapp/app/widgets/custom_text_feild_form.dart';
import 'package:resumebuilderapp/app/widgets/rounded_button.dart';

class AddReferenceDialog extends StatefulWidget {
  final Reference reference;

  const AddReferenceDialog({super.key, required this.reference});

  @override
  _AddReferenceDialogState createState() => _AddReferenceDialogState();
}

class _AddReferenceDialogState extends State<AddReferenceDialog> {
  late TextEditingController _nameController;
  late TextEditingController _designationController;
  late TextEditingController _emailController;
  late TextEditingController _companyController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.reference != null ? widget.reference.name : '');
    _emailController = TextEditingController(text: widget.reference != null ? widget.reference.email : '');
    _designationController = TextEditingController(text: widget.reference != null ? widget.reference.designation : '');
    _companyController = TextEditingController(text: widget.reference != null ? widget.reference.company : '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _designationController.dispose();
    _companyController.dispose();
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
          'Add Reference',
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
                hintText: 'Reference person name ...',
                helperText: 'Name',
                validator: (val) => val!.isEmpty
                    ? 'Empty name'
                    : val.length < 2
                        ? 'Invalid name'
                        : null,
              ),
              const SizedBox(height: 12.0),
              CustomTextFieldForm(
                controller: _designationController,
                hintText: 'Designation ...',
                helperText: 'Designation',
                validator: (val) => val!.isEmpty ? 'Empty designation' : null,
              ),
              const SizedBox(height: 12.0),
              CustomTextFieldForm(
                controller: _companyController,
                hintText: 'Company name ...',
                helperText: 'Company',
                validator: (val) => val!.isEmpty ? 'Empty company name' : null,
              ),
              const SizedBox(height: 12.0),
              CustomTextFieldForm(
                controller: _emailController,
                hintText: 'Email?',
                helperText: 'Email',
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
              const SizedBox(height: 24.0),
              RoundedButton(
                text: 'Add',
                onPressed: onAddReference,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onAddReference() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Get.back(
        result: Reference(
          designation: _designationController.text,
          name: _nameController.text,
          email: _emailController.text,
          company: _companyController.text,
        ),
      );
      // Navigator.of(context).pop(
      //   Reference(
      //     designation: _designationController.text,
      //     name: _nameController.text,
      //     email: _emailController.text,
      //     company: _companyController.text,
      //   ),
      // );
    }
  }
}
