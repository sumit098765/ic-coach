import 'package:flutter/material.dart';
import 'package:instacoach/presentation/widgets/text_widget.dart';

import '../../utils/constants/colors.dart';

class GoogleBtn1 extends StatelessWidget {
  final Function() onPressed;
  const GoogleBtn1({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
          backgroundColor: AppColors.white,
          fixedSize: const Size(390, 44),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          side: const BorderSide(width: 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/logos/google.png",
            height: 42,
          ),
          const TextWidget(
            text: "Continue with google",
            color: AppColors.black,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
