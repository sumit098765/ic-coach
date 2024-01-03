import 'package:flutter/material.dart';
import 'package:instacoach/utils/constants/colors.dart';

InputDecoration textFieldMainDecoration({
  required String hintText,
  Icon? icon,
  required String labelText,
  TextStyle? labelStyle,
  bool isMandatory = false,
}) {
  String mandatoryLabel = labelText;
  if (isMandatory) {
    mandatoryLabel +=
        ' *'; // Add asterisk to the label text for mandatory fields
  }

  const defaultLabelStyle =  TextStyle(fontSize: 14);
  final updatedLabelStyle = labelStyle?.merge(TextStyle(
        fontSize: defaultLabelStyle.fontSize,
        color: Colors.red, // Customize the asterisk color if needed
      )) ??
      defaultLabelStyle;

  return InputDecoration(
    prefixIcon: icon,
    filled: true,
    fillColor: Colors.white,
    hintText: hintText == '' ? null : hintText,
    counterText: '',
    focusColor: AppColors.selectedBlue,
    
    labelText:
        labelText == '' ? null : mandatoryLabel, // Use the updated label text with the asterisk for mandatory fields
    labelStyle: updatedLabelStyle,
    hintStyle: const TextStyle(fontSize: 14),

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
    contentPadding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
  );
}
