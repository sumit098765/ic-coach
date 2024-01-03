import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextDecoration? textDecoration;
  final String? fontFamily;
  final TextOverflow? textOverflow;
  const TextWidget(
      {super.key, required this.text,
      this.fontSize,
      this.fontWeight,
      this.color,
      this.textDecoration,
      this.fontFamily,
      this.textOverflow,
      });

  @override
  Widget build(BuildContext context) {
    return Text(
     
      text,
      style: TextStyle(
         overflow:textOverflow ,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          decoration: textDecoration,
          fontFamily: fontFamily),
    );
  }
}
