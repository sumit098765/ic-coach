// ignore_for_file: unrelated_type_equality_checks

import 'dart:developer';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instacoach/domain/models/reservation_model/get_single_package_model.dart';
import 'package:instacoach/domain/models/reservation_model/get_single_reservation_model.dart';
import 'package:instacoach/logic/cubits/reservation_cubits/get_package_reservation/package_reservation_state.dart';
import 'package:instacoach/presentation/widgets/top_details_of_drs.dart';

import '../../logic/cubits/reservation_cubits/get_package_reservation/package_reservation_cubit.dart';
import '../../utils/constants/colors.dart';
import 'cancel_request_bottom_sheet_widget.dart';
import 'decoration.dart';
import 'gradient_button.dart';
import 'text_widget.dart';

class ExpansionTilesWidget extends StatefulWidget {
  const ExpansionTilesWidget(
      {super.key,
      this.cardA,
      required this.onTapped,
      required this.title,
      required this.subTitle,
      this.icon,
      required this.color,
      required this.elevation,
      required this.isBooking,
      this.cardB,
      this.index,
      this.SingleReservation,
      this.reservationId,
      this.purchaseType});
  final String? reservationId;
  final String? purchaseType;
  final String? title;
  final String? subTitle;
  final IconData? icon;
  final GlobalKey<ExpansionTileCardState>? cardA;
  final List<GlobalKey<ExpansionTileCardState>>? cardB;
  final Function() onTapped;
  final Color color;
  final double elevation;
  final int isBooking;
  final int? index;
  final GetSingleReservationModel? SingleReservation;

  @override
  State<ExpansionTilesWidget> createState() => _ExpansionTilesWidgetState();
}

class _ExpansionTilesWidgetState extends State<ExpansionTilesWidget> {
  @override
  void initState() {
    final packageCubit = context.read<GetSinglePackageReservationCubit>();
    packageCubit.fetchSinglePackageReservation(
        widget.reservationId ?? '', widget.purchaseType ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSinglePackageReservationCubit,
        GetSinglePackageReservatioState>(
      builder: (context, state) {
        if (state is GetSinglePackageReservatioLodaingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.black,
            ),
          );
        } else if (state is GetSinglePackageReservatioLoadedState) {
          ReservationPackageModel packages = state.reservationPackage;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: reusableDecoration(),
                    child: topDetails(widget.SingleReservation!)),
                const SizedBox(
                  height: 20,
                ),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: packages.data.reservationTimes.length,
                    itemBuilder: (context, index) {
                      log("length of packs........${packages.data.reservationTimes.length}");
                      log(" index of each tile $index");
                      final rvt = packages.data.reservationTimes[index];
                      bool isCancelDisabled = rvt.reqCancelStatus ?? false;
                      bool isRescheduleDisabled =
                          rvt.reqRescheduleStatus ?? false;
                      bool isConfirmDisabled = rvt.reqConfirmStatus ?? false;

                      log("confirm $isConfirmDisabled");
                      log("cancel $isCancelDisabled");
                      log("reschedule $isRescheduleDisabled");
                      return _expansionCard(
                          index,
                          packages,
                          context,
                          isCancelDisabled,
                          isConfirmDisabled,
                          isRescheduleDisabled);
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Text("Something went wrong");
        }
      },
    );
  }

  Padding _expansionCard(
      int index,
      ReservationPackageModel packages,
      BuildContext context,
      bool isCancelDisabled,
      bool isConfirmDisabled,
      bool isRescheduleDisabled) {
    UniqueKey uniqueKey = UniqueKey();

    log("value key $uniqueKey");
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.lightBlue,
            )),
        child: ExpansionTileCard(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          borderRadius: BorderRadius.circular(16),

          elevation: 0,
          baseColor: AppColors.white,
          expandedColor: AppColors.white,
          key: uniqueKey,

          title: TextWidget(
            text: widget.title.toString(),
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
          //subtitle: TextWidget(text: widget.subTitle.toString()),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("assets/images/pin.svg"),
                      const SizedBox(
                        width: 10,
                      ),
                      const TextWidget(
                        text: "Where will we meet?",
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextWidget(
                      text: packages.data.reservationTimes[index].location ??
                          "Palo Alto, CA",
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(
                    thickness: 1,
                    color: AppColors.lightBlue,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      gradientButton1(
                          context: context,
                          rWidth: 350,
                          rHeight: 38.sp,
                          image: 'assets/images/clock.svg',
                          btnText: isRescheduleDisabled
                              ? "Rescheduled Requ.."
                              : "Reschedule Request",
                          color: isRescheduleDisabled
                              ? AppColors.textLightGrey
                              : AppColors.black,
                          onPress: isRescheduleDisabled
                              ? () {}
                              : () {
                                  //  currentIndex = index;
                                  CancelBottomSheetWidget.showModal(
                                      context,
                                      "Reschedule Request",
                                      "Are you sure want to\n     Reschedule?",
                                      widget.SingleReservation!
                                          .combinedReservation!.coachId
                                          .toString(),
                                      packages.data.reservationTimes[index]
                                          .reservationTimeId
                                          .toString(),
                                      "reschedule",
                                      widget.purchaseType.toString(),
                                      widget.reservationId.toString());
                                  // SessionRescheduleShBottomeetWidget
                                  //     .showModal(context);
                                },
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                      const SizedBox(
                        height: 10,
                      ),
                      gradientButton1(
                          context: context,
                          rWidth: 305.sp,
                          rHeight: 38.sp,
                          btnText: isCancelDisabled
                              ? "Canceled Request"
                              : "Cancel Request",
                          txtColor: isCancelDisabled
                              ? AppColors.textLightGrey
                              : AppColors.black,
                          color: AppColors.lightGrey,
                          onPress: isCancelDisabled
                              ? () {}
                              : () {
                                  // log("current index before show $currentIndex");
                                  CancelBottomSheetWidget.showModal(
                                      context,
                                      "Cancel Session",
                                      "Are you sure want to\n    cancel request?",
                                      widget.SingleReservation!
                                          .combinedReservation!.coachId
                                          .toString(),
                                      packages.data.reservationTimes[index]
                                          .reservationTimeId
                                          .toString(),
                                      "cancel",
                                      widget.purchaseType.toString(),
                                      widget.reservationId.toString());
                                  // log("current index After show $currentIndex");
                                },
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    thickness: 1,
                    color: AppColors.lightBlue,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  gradientButton1(
                      context: context,
                      rWidth: 305.sp,
                      rHeight: 48,
                      btnText: isConfirmDisabled
                          ? "Confirmed Session"
                          : "Confirm Session",
                      color: isConfirmDisabled
                          ? AppColors.textLightGrey
                          : AppColors.selectedBlue,
                      onPress: isConfirmDisabled
                          ? () {}
                          : () {
                              //  currentIndex = index;
                              //("current index before show $currentIndex");
                              CancelBottomSheetWidget.showModal(
                                  context,
                                  "Confirm Session",
                                  "Are you sure want to?\n          Comfirm",
                                  widget.SingleReservation!.combinedReservation!
                                      .coachId
                                      .toString(),
                                  packages.data.reservationTimes[index]
                                      .reservationTimeId
                                      .toString(),
                                  "confirm",
                                  widget.purchaseType.toString(),
                                  widget.reservationId.toString());
                              //  log("current index After show $currentIndex");
                            },
                      fontSize: 15,
                      fontWeight: FontWeight.w700)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
