import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:instacoach/presentation/widgets/text_widget.dart';

import '../../domain/models/reservation_model/get_single_reservation_model.dart';
import '../../utils/constants/colors.dart';
import 'package:intl/intl.dart';

Column topDetails(GetSingleReservationModel singleReservation) {
  log("OnSched Time in top details ${singleReservation.combinedReservation!.onschedEventTime ?? "2023-11-30T21:30:00+00:00"}");
  DateTime dateTime = DateTime.parse(
          singleReservation.combinedReservation?.onschedEventTime ??
              "2023-11-30T21:30:00+00:00")
      .toLocal();

  String formattedDate = DateFormat("MMM d, yyyy").format(dateTime);
  String formattedTime = DateFormat("hh:mm a").format(dateTime);

  String calculateType(String purchaseType, String? sessionType) {
    if (sessionType == null) {
      return purchaseType.substring(0, 1).toUpperCase() +
          purchaseType.substring(1);
    }
    if (purchaseType == 'single' && sessionType.toLowerCase() == 'individual') {
      return 'Single';
    } else if (purchaseType == 'single' &&
        sessionType.toLowerCase() == 'group') {
      return 'Group';
    } else if (purchaseType == 'package' &&
        sessionType.toLowerCase() == 'individual') {
      return 'Package';
    } else {
      return '';
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextWidget(
        text: singleReservation.combinedReservation!.location
            .toString(), //"Palo Alto, CA",
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
        textOverflow: TextOverflow.ellipsis,
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        children: [
          Container(
            height: 25,
            width: 90,
            decoration: BoxDecoration(
                color: singleReservation.combinedReservation!.type ==
                        "In-Person"
                    ? AppColors.pink
                    : singleReservation.combinedReservation!.type == "Virtual"
                        ? AppColors.lightyellow
                        : AppColors.pink,
                borderRadius: BorderRadius.circular(13)),
            child: Center(
              child: TextWidget(
                text: singleReservation.combinedReservation!.type.toString(),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Container(
            height: 25,
            width: 90,
            decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.circular(13)),
            child: Center(
              child: TextWidget(
                text: calculateType(
                    singleReservation.combinedReservation!.purchaseType
                        as String,
                    singleReservation.combinedReservation!.sessionType),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      TextWidget(
        text: "$formattedTime | $formattedDate ",

        // "12:00 AM - 1:00 PM | Jun 15, 2023",
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColors.subBlack,
      ),
    ],
  );
}
