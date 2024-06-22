import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resumebuilderapp/app/utils/app_colors.dart';

class CustomTextFieldForm extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String helperText;
  TextInputType? textInputType;
  String? Function(String?)? validator;
  int? maxLines;
  InputBorder? inputBorder;
  List<TextInputFormatter>? inputFormatter;
  int? maxLength;
  bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: AppColors.black,
        fontSize: MediaQuery.of(context).size.shortestSide * 0.05,
        letterSpacing: 1.2,
      ),
      decoration: InputDecoration(
        border: inputBorder ?? InputBorder.none,
        hintText: hintText,
        helperText: helperText,
        counterText: '',
        helperStyle: TextStyle(
          color: AppColors.grey,
          fontSize: MediaQuery.of(context).size.shortestSide * 0.03,
          letterSpacing: 0.8,
        ),
        errorStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.shortestSide * 0.03,
          letterSpacing: 0.8,
        ),
      ),
      keyboardType: textInputType ?? TextInputType.text,
      controller: controller,
      maxLines: maxLines ?? 1,
      validator: validator,
      inputFormatters: inputFormatter ?? [],
      maxLength: maxLength,
      readOnly: readOnly ?? false,
    );
  }

  CustomTextFieldForm({
    super.key,
    required this.controller,
    required this.helperText,
    required this.hintText,
    this.textInputType,
    this.validator,
    this.maxLines,
    this.inputBorder,
    this.inputFormatter,
    this.maxLength,
    this.readOnly,
  });
}
