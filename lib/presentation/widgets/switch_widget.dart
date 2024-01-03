import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:instacoach/presentation/widgets/text_widget.dart';
import 'package:instacoach/utils/constants/colors.dart';

class SwitchWidget extends StatefulWidget {
  final bool? initialStatus;
  final Color switchColor;
  final Function(bool)? onChanged;
  final String switchText;
  final Color? textColor;
  final bool? isVisible;
  //final VoidCallback? onTap;
  const SwitchWidget({
    Key? key,
    this.initialStatus,
    required this.switchColor,
    this.onChanged,
    required this.switchText,
    required this.isVisible,
    this.textColor = AppColors.black,
  }) : super(key: key);

  @override
  SwitchWidgetState createState() => SwitchWidgetState();
}

class SwitchWidgetState extends State<SwitchWidget> {
  late bool status;

  @override
  void initState() {
    super.initState();
    status = widget.initialStatus ?? false;
  }

  @override
  Widget build(BuildContext context) {
    // log("isVisible  ${widget.isVisible}");
    return Row(
      children: [
        FlutterSwitch(
          width: 52.sp,
          height: 25.sp,
          activeColor: widget.switchColor,
          toggleSize: 21,
          inactiveColor: const Color(0xFFD1D1D6),
          value: status,
          onToggle: widget.isVisible == true
              ? (value) {
                  status = value;
                  log("Status $status");
                  widget.onChanged!.call(value);
                }
              : (value) {
                  setState(() {
                    // widget.switchText == "Sundays"
                    //     ? status = false
                    //     :
                    status = value;
                    widget.onChanged!.call(value);
                  });
                },
        ),
        const SizedBox(
          width: 10,
        ),
        TextWidget(
          text: widget.switchText,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color:widget.textColor
        ),
      ],
    );
  }
}
