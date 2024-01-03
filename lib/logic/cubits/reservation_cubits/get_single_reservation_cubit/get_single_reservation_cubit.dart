import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/repositories/api_repositories.dart';
import 'get_single_reservation_state.dart';

class GetSingleReservationCubit extends Cubit<GetSingleReservatioState> {
  ApiServices services;
  GetSingleReservationCubit(this.services)
      : super(GetSingleReservatioLodaingState());

  Future fetchSingleReservation(String reservId, String reserType) async {
    try {
      emit(GetSingleReservatioLodaingState());
      final data = await services.getSingleReservationRespository(reservId);
      log("data:::::::::::::::::::::::::::::::::::::::::: ${data.data!}");
      if (data.data!.combinedReservation != null) {
        emit(GetSingleReservatioLoadedState(data.data!));
      }
    } catch (e) {
      log("get single reservation cubit error>::::::::::::::::::::::::::: $e");
      emit(GetSingleReservatioErrorState(message: 'Something went wrong'));
    }
  }
}
