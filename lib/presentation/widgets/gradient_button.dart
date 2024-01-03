import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instacoach/presentation/widgets/text_widget.dart';
import 'package:instacoach/utils/constants/colors.dart';

ElevatedButton gradientButton1({
  required BuildContext context,
  required double rWidth,
  required double rHeight,
  required String btnText,
  required Color color,
  required double fontSize,
  Color? txtColor,
  required FontWeight fontWeight,
  String? image,
  required VoidCallback onPress,
}) {
  return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
          elevation: 0,
          fixedSize: Size(rWidth, rHeight),
          backgroundColor: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      child: image == null
          ? TextWidget(
              text: btnText,
              color: txtColor ?? AppColors.white,
              fontSize: fontSize,
              fontWeight: fontWeight,
              textOverflow: TextOverflow.ellipsis,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  image,
                  height: 16.sp,
                  width: 16.sp,
                ),
                const SizedBox(
                  width: 13,
                ),
                TextWidget(
                  color: txtColor ?? AppColors.white,
                  text: btnText,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ],
            ));
}
