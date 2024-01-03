import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

InputDecoration passwordFieldDecoration(
    {required String labelText,
    TextStyle? labelStyle,
    String? hintTxt,
    bool isMandatory = false,
    bool passwordVisible = false,
    required VoidCallback togglePassword}) {
  String mandatoryLabel = labelText;
  if (isMandatory) {
    mandatoryLabel += ' *';
  }

  const defaultLabelStyle = TextStyle(fontSize: 14);
  final updatedLabelStyle = labelStyle?.merge(TextStyle(
        fontSize: defaultLabelStyle.fontSize,
        color: Colors.red,
      )) ??
      defaultLabelStyle;

  return InputDecoration(
    suffixIcon: IconButton(
      splashRadius: 1,
      icon: Icon(passwordVisible
          ? Icons.visibility_outlined
          : Icons.visibility_off_outlined),
      onPressed: togglePassword,
    ),
    //prefixIcon: const Icon(Icons.lock_outline),
    filled: true,
    fillColor: Colors.white,
    hintText: hintTxt == '' ? null : hintTxt,
    hintStyle: const TextStyle(fontSize: 14),
    labelText: labelText == '' ? null : mandatoryLabel,
    labelStyle: updatedLabelStyle,
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFDBE7FF)),
      borderRadius: BorderRadius.circular(10.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.red),
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.selectedBlue),
      borderRadius: BorderRadius.circular(10.0),
    ),
    contentPadding: const EdgeInsets.fromLTRB(12, 16, 12, 8)
  );
}
