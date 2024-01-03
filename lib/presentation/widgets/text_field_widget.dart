import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:instacoach/presentation/widgets/text_widget.dart';
import 'package:instacoach/utils/constants/colors.dart';

class TextFieldWidget extends StatefulWidget {
  TextFieldWidget(
      {Key? key,
      required this.textEditingController,
      required this.isPass,
      this.hintText,
      required this.editMode,
      required this.labelText,
      this.validator,
      required this.textInputType,
      this.onChanged})
      : super(key: key);

  final TextEditingController textEditingController;
  final bool isPass;
  final String? hintText;
  final String labelText;
  bool editMode;
  final TextInputType? textInputType;
  String Function(String?)? validator;
  Function(String)? onChanged;
  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  void initState() {
    widget.textEditingController.text = widget.labelText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("message isEditMode ${widget.editMode}");
    return TextFormField(
      enabled: widget.editMode,
      controller: widget.textEditingController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: widget.textInputType,
      validator: widget.validator,
      autofocus: false,
      onChanged: widget.onChanged,
      style: TextStyle(
        color: widget.editMode ? AppColors.grey3 : AppColors.black,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
    );
  }
}
