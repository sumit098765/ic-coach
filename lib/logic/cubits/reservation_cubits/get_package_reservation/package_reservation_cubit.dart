import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instacoach/logic/cubits/reservation_cubits/get_package_reservation/package_reservation_state.dart';
import '../../../../domain/repositories/api_repositories.dart';

class GetSinglePackageReservationCubit
    extends Cubit<GetSinglePackageReservatioState> {
  ApiServices services;
  GetSinglePackageReservationCubit(this.services)
      : super(GetSinglePackageReservatioLodaingState());

  Future fetchSinglePackageReservation(
      String reservId, String reserType) async {
    try {
      emit(GetSinglePackageReservatioLodaingState());
      final data =
          await services.getSinglePackageReservationRespository(reservId);
      log("data:::::::::::::::::::::::::::::::::::::::::: ${data.data!}");
      if (data.data?.data.reservationTimes != null) {
        emit(GetSinglePackageReservatioLoadedState(data.data!));
      }
    } catch (e) {
      log("Pacakge reservation cubit error>::::::::::::::::::::::::::: $e");
      emit(GetSinglePackageReservatioErrorState(
          message: 'Something went wrong'));
    }
  }
}
