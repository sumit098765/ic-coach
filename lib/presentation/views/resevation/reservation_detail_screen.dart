import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instacoach/domain/models/reservation_model/get_single_reservation_model.dart';
import 'package:instacoach/logic/cubits/reservation_cubits/get_single_reservation_cubit/get_single_reservation_cubit.dart';
import 'package:instacoach/logic/cubits/reservation_cubits/get_single_reservation_cubit/get_single_reservation_state.dart';
import 'package:instacoach/presentation/widgets/appbar.dart';
import 'package:instacoach/presentation/widgets/gradient_button.dart';
import 'package:instacoach/presentation/widgets/presistent_navigation_widget.dart';
import 'package:instacoach/presentation/widgets/text_widget.dart';
import 'package:instacoach/utils/constants/colors.dart';
import '../../../logic/cubits/notification_cubit/get_notify_count_cubit/get_notify_count_cubit.dart';
import '../../../logic/cubits/notification_cubit/get_notify_count_cubit/get_notify_count_state.dart';
import '../../widgets/cancel_request_bottom_sheet_widget.dart';
import '../../widgets/decoration.dart';
import '../../widgets/reservation_Package_details_widget.dart';
import '../../widgets/top_details_of_drs.dart';
import 'notification_screen.dart';

class ReservationDetailScreen extends StatefulWidget {
  const ReservationDetailScreen(
      {super.key,
      this.reservationId,
      this.purchaseType,
      this.index,
      required this.CoachId});
  final String? reservationId;
  final String? purchaseType;
  final int? index;
  final String CoachId;

  @override
  State<ReservationDetailScreen> createState() =>
      _ReservationDetailScreenState();
}

class _ReservationDetailScreenState extends State<ReservationDetailScreen> {
  @override
  void initState() {
    final getSingleReservationCubit = context.read<GetSingleReservationCubit>();
    getSingleReservationCubit.fetchSingleReservation(
        widget.reservationId ?? '', widget.purchaseType ?? "");

    super.initState();
  }

  // final msg = BlocBuilder<RCCReuestCubit, RCCState>(builder: (context, state) {
  //   if (state is RCCLodaingState) {
  //     return const Center(
  //       child: CircularProgressIndicator(
  //         color: AppColors.black,
  //       ),
  //     );
  //   } else {
  //     return Container();
  //   }
  // });

  @override
  Widget build(BuildContext context) {
    //log("Reservation id ${widget.reservationId}");
    return Scaffold(
      appBar: appbar2(
        context: context,
        title: "Reservation",
        visible: true,
        icon: InkWell(
            onTap: () {
              presistentNavigationWidget(
                  context,
                  NotificationScreen(
                    CoachID: widget.CoachId,
                  ));
            },
            child: Stack(
              children: [
                SvgPicture.asset("assets/images/notify.svg", height: 24),
                BlocBuilder<GetNotifyCountCubit, GetNotifyCountState>(
                  builder: (context, state) {
                    if (state is GetNotifyCountLoadingState) {
                      return const Center();
                    } else if (state is GetNotifyCountLoadedState) {
                      final count = state.notifyCount;
                      // log("Count ${count.data.count}");
                      return count.data.count == '0'
                          ? const SizedBox()
                          : Positioned(
                              left: 9,
                              child: SizedBox(
                                height: 15,
                                width: 15,
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      "assets/images/badge.png",
                                      // height: 15,
                                      color: AppColors.red,
                                    ),
                                    Center(
                                      child: TextWidget(
                                        text: count.data.count.toString(),
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                    }
                    return const TextWidget(text: "X");
                  },
                )
              ],
            )),
      ),
      body: BlocBuilder<GetSingleReservationCubit, GetSingleReservatioState>(
        builder: (context, state) {
          if (state is GetSingleReservatioLodaingState) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.black,
            ));
          } else if (state is GetSingleReservatioLoadedState) {
            GetSingleReservationModel singleReservation =
                state.getSingleReservation;

            bool isCancelDisabled =
                singleReservation.combinedReservation?.reqCancelStatus ?? false;
            bool isRescheduleDisabled =
                singleReservation.combinedReservation?.reqRescheduleStatus ??
                    false;
            bool isConfirmDisabled =
                singleReservation.combinedReservation?.reqConfirmStatus ??
                    false;
            return SingleChildScrollView(
              child: Stack(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: widget.purchaseType == "single"
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: reusableDecoration(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    topDetails(singleReservation),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: AppColors.lightBlue,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/images/pin.svg"),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const TextWidget(
                                          text: "Where will we meet?",
                                          fontSize: 17,
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
                                        text: singleReservation
                                            .combinedReservation!.location
                                            .toString(), //"Palo Alto, CA",
                                        fontSize: 14,
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
                                      height: 15,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        gradientButton1(
                                            context: context,
                                            rWidth: 350,
                                            rHeight: 38.sp,
                                            image: 'assets/images/clock.svg',
                                            btnText: isRescheduleDisabled
                                                ? "Reschedule Requested"
                                                : "Reschedule Request",
                                            color: isRescheduleDisabled
                                                ? AppColors.textLightGrey
                                                : AppColors.black,
                                            onPress: isRescheduleDisabled
                                                ? () {}
                                                : () {
                                                    CancelBottomSheetWidget
                                                        .showModal(
                                                      context,
                                                      "Reschedule Request",
                                                      "Are you sure you want to Reschedule?",
                                                      singleReservation
                                                          .combinedReservation!
                                                          .coachId
                                                          .toString(),
                                                      singleReservation
                                                          .combinedReservation!
                                                          .reservationId
                                                          .toString(),
                                                      "reschedule",
                                                      widget.purchaseType
                                                          .toString(),
                                                      singleReservation
                                                          .combinedReservation!
                                                          .reservationId
                                                          .toString(),
                                                    );
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
                                            rWidth: 350,
                                            rHeight: 38.sp,
                                            btnText: isCancelDisabled
                                                ? "Cancel Requested"
                                                : "Cancel Request",
                                            txtColor: isCancelDisabled
                                                ? AppColors.textLightGrey
                                                : AppColors.black,
                                            color: AppColors.lightGrey,
                                            onPress: isCancelDisabled
                                                ? () {}
                                                : () {
                                                    CancelBottomSheetWidget
                                                        .showModal(
                                                      context,
                                                      "Cancel Session",
                                                      "Are you sure you want to Cancel?",
                                                      singleReservation
                                                          .combinedReservation!
                                                          .coachId
                                                          .toString(),
                                                      singleReservation
                                                          .combinedReservation!
                                                          .reservationId
                                                          .toString(),
                                                      "cancel",
                                                      widget.purchaseType
                                                          .toString(),
                                                      singleReservation
                                                          .combinedReservation!
                                                          .reservationId
                                                          .toString(),
                                                    );
                                                  },
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              gradientButton1(
                                  context: context,
                                  rWidth: 350,
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
                                          CancelBottomSheetWidget.showModal(
                                            context,
                                            "Confirm Session",
                                            "Are you sure you want to Comfirm?",
                                            singleReservation
                                                .combinedReservation!.coachId
                                                .toString(),
                                            singleReservation
                                                .combinedReservation!
                                                .reservationId
                                                .toString(),
                                            "confirm",
                                            widget.purchaseType.toString(),
                                            singleReservation
                                                .combinedReservation!
                                                .reservationId
                                                .toString(),
                                          );
                                        },
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          )
                        : ExpansionTilesWidget(
                            onTapped: () {},
                            title: singleReservation
                                .combinedReservation!.sessionTitle,
                            subTitle: "",
                            color: AppColors.lightGrey,
                            elevation: 1,
                            isBooking: 1,
                            index: widget.index,
                            SingleReservation: singleReservation,
                            reservationId: widget.reservationId,
                            purchaseType: widget.purchaseType,
                          )),
                // msg,
              ],
            ));
          } else {
            return const Text("Error");
          }
        },
      ),
    );
  }
}
