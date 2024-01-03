import 'package:flutter/material.dart';
import 'package:instacoach/utils/constants/colors.dart';
import 'package:flutter/services.dart';

import 'text_widget.dart';

PreferredSizeWidget appbar1({
  required BuildContext context,
  required String title,
  required bool visible,
  PreferredSizeWidget? preferredSize,
  required Widget icon,
}) =>
    AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: TextWidget(
        text: title,
        color: AppColors.black,
        fontSize: 21,
        fontWeight: FontWeight.w600,
      ),
      automaticallyImplyLeading: visible,
      actions: [IconButton(onPressed: () {}, icon: icon)],
       bottom: preferredSize,
      systemOverlayStyle: SystemUiOverlayStyle.dark
    );

PreferredSizeWidget appbar2({
  required BuildContext context,
  required String title,
  required bool visible,
  PreferredSizeWidget? preferredSize,
  Widget? icon,
}) =>
    AppBar(
      backgroundColor: AppColors.white,
      scrolledUnderElevation: 0,
      elevation: 0,
      leading: visible
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.chevron_left,
                color: AppColors.black,
                size: 30,
              ),
            )
          : const Text(""),
      title: TextWidget(
        text: title,
        color: AppColors.black,
        fontSize: 21,
        fontWeight: FontWeight.w600,
      ),
      //automaticallyImplyLeading: visible,
      actions: icon != null ? [IconButton(onPressed: () {}, icon: icon)] : [], // Adjusted to handle null icon
      bottom: preferredSize,
      systemOverlayStyle: SystemUiOverlayStyle.dark
    );
