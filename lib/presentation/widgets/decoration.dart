  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants/colors.dart';

BoxDecoration reusableDecoration() {
    return BoxDecoration(
        color: AppColors.white,
        boxShadow: const [
          BoxShadow(blurRadius: 1, spreadRadius: 1, color: AppColors.lightBlue)
        ],
        borderRadius: BorderRadius.circular(16.sp));
  }