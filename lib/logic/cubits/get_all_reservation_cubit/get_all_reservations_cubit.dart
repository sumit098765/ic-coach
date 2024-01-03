import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/api_repositories.dart';

part 'get_all_reservations_state.dart';

class GetAllReservationCubit extends Cubit<GetAllReservationsState> {
  GetAllReservationCubit(this.apiServices)
      : super(GetAllReservationLoadingState());

  ApiServices apiServices;

  Future loadPosts(String coachId, int pageNumber) async {
    try {
      if (pageNumber == 1) {
        emit(GetAllReservationLoadingState());
      }

      final data =
          await apiServices.getAllReservationRespository(coachId, pageNumber);
      log("data:::::::::::::::::::::::::::::::::::::::::: ${data.data!.data}");
      if (pageNumber == 1 && data.data!.data!.reservation!.rows!.isEmpty) {
        log("Data is null on the first page");
        emit(const GetAllReservationLoadedState([]));
        emit(const GetAllReservatioLoadedEmptyState("No reservation yet"));
      } else if (data.data!.data!.reservation!.rows!.isNotEmpty) {
        emit(GetAllReservationLoadedState(data.data!.data!.reservation!.rows!));
        log("Data is coming ");
      } else {}
    } catch (e) {
      log("EEEEE>::::::::::::::::::::::::::: $e");
      emit(ErrorState(e.toString()));
    }
  }
}
