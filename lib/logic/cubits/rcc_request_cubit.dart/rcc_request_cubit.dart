import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instacoach/logic/cubits/rcc_request_cubit.dart/rcc_request_state.dart';
import '../../../../domain/repositories/api_repositories.dart';
import '../reservation_cubits/get_package_reservation/package_reservation_cubit.dart';
import '../reservation_cubits/get_single_reservation_cubit/get_single_reservation_cubit.dart';

class RCCReuestCubit extends Cubit<RCCState> {
  ApiServices services;
  RCCReuestCubit(this.services) : super(RCCLodaingState());

  Future rccRequests(
      String coachId,
      String reserId,
      String requestType,
      String purchaseType,
      GetSinglePackageReservationCubit getSinglePackageReservationCubit,
      GetSingleReservationCubit getSingleReservationCubit) async {
    log("Inside RCC");
    try {
      emit(RCCLodaingState());
      final data = await services.rccRequestRepository(
        coachId,
        reserId,
        requestType,
        purchaseType,
      );
      // log("data:::::::::::::::::::::::::::::::::::::::::: ${data.data!}");
      if (data.data == "OK") {
        emit(RCCLoadedState(data.data));
        // if (purchaseType == "package") {
        //   await getSinglePackageReservationCubit.fetchSinglePackageReservation(
        //       reserId, purchaseType);
        // } else {
        //   await getSingleReservationCubit.fetchSingleReservation(
        //       reserId, purchaseType);
        // }
      } else if (data.data.message ==
          "Selected Reservation should be of scheduled state") {
        emit(RCCNotScheduledNowState(
            "Selected Reservation should be of scheduled state"));
      }
    } catch (e) {
      log("RCC Error >::::::::::::::::::::::::::: $e");
      emit(RCCErrorState(message: 'Something went wrong'));
    }
  }
}
