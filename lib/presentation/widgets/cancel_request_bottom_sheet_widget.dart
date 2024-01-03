// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instacoach/logic/cubits/reservation_cubits/get_package_reservation/package_reservation_cubit.dart';
import 'package:instacoach/presentation/widgets/gradient_button.dart';
import 'package:instacoach/presentation/widgets/text_widget.dart';
import 'package:instacoach/utils/constants/colors.dart';

import '../../logic/cubits/rcc_request_cubit.dart/rcc_request_cubit.dart';
import '../../logic/cubits/rcc_request_cubit.dart/rcc_request_state.dart';
import '../../logic/cubits/reservation_cubits/get_single_reservation_cubit/get_single_reservation_cubit.dart';

class CancelBottomSheetWidget {
  static showModal(
    BuildContext context,
    String headingText,
    String msgText,
    String coachID,
    String reservationId,
    String requestTypes,
    String resType,
    String dumReservationId,
  ) {
    bool isLoading = false;
    log("request Type $requestTypes");
    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return BlocListener<RCCReuestCubit, RCCState>(
            listener: (context, state) {
          if (state is RCCLoadedState) {
            Fluttertoast.showToast(msg: "Request sent successfully");
          } else if (state is RCCNotScheduledNowState) {
            Fluttertoast.showToast(
                msg: state.message, toastLength: Toast.LENGTH_LONG);
          } else if (state is RCCErrorState) {
            Fluttertoast.showToast(msg: "Request sent successfully");
          }
        }, child: StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
                height: 376,
                child: Center(
                    child: Column(
                  children: [
                    const SizedBox(
                      height: 28,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextWidget(
                          text: headingText,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
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
                    headingText == "Cancel Session"
                        ? SvgPicture.asset("assets/images/x.svg")
                        : headingText == "Reschedule Request"
                            ? Image.asset('assets/images/clock.png', height: 70)
                            : headingText == "Confirm Session"
                                ? SvgPicture.asset(
                                    "assets/images/tick.svg",
                                    height: 70,
                                  )
                                : const TextWidget(text: "N?A"),
                    const SizedBox(
                      height: 5,
                    ),
                    TextWidget(
                      text: msgText,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: gradientButton1(
                          context: context,
                          rWidth: 390,
                          rHeight: 44,
                          btnText: "Yes",
                          color: AppColors.selectedBlue,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          onPress: isLoading == true
                              ? () {}
                              : () async {
                                  setState(
                                    () {
                                      isLoading = true;
                                    },
                                  );
                                  final rccCubit =
                                     context.read<RCCReuestCubit>();
                                  await rccCubit.rccRequests(coachID,
                                      reservationId, requestTypes, resType,BlocProvider.of<GetSinglePackageReservationCubit>(context),BlocProvider.of<GetSingleReservationCubit>(context));

                                  Navigator.pop(context);
                                 final newContext = context;

                                  final packageCubit = newContext
                                      .read<GetSinglePackageReservationCubit>();
                                  packageCubit.fetchSinglePackageReservation(
                                      reservationId, resType);

                                  final getSingleReservationCubit = newContext
                                      .read<GetSingleReservationCubit>();
                                  getSingleReservationCubit
                                      .fetchSingleReservation(
                                          dumReservationId, resType);

                                  setState(
                                    () {
                                      isLoading = false;
                                    },
                                  );
                                }),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: gradientButton1(
                          context: context,
                          rWidth: 390,
                          rHeight: 44,
                          btnText: "No",
                          color: AppColors.lightGrey,
                          fontSize: 15,
                          txtColor: AppColors.black,
                          fontWeight: FontWeight.w700,
                          onPress: () {
                            Navigator.pop(context);
                          }),
                    ),
                  ],
                )));
          },
        ));
      },
    );
  }
}
