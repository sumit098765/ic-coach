import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/repositories/api_repositories.dart';
import 'filter_state.dart';

class FilterCubit extends Cubit<FilterState1> {
  ApiServices services;
  FilterCubit(this.services) : super(FilterLodaingState());

  Future fetchAccToFilter(String coachId, String param, int page) async {
    try {
    // emit(FilterLodaingState());
     if (page == 1) {
        emit(FilterLodaingState()); // Emit loading state only for the initial fetch
      }
      final data = await services.filterRespository(coachId, param, page);
      log("data:::::::::::::::::::::::::::::::::::::::::: ${data.data!.data}");
      if (page == 1 && data.data!.data!.reservation!.rows!.isEmpty) {
        emit(FilterEmptyState("No Reservations Found"));
        log("null is triggered in filter");
      } else if (data.data!.data!.reservation!.rows!.isNotEmpty) {
        emit(FilterLoadedState(data.data!));
        log("filter loaded");
      }
    } catch (e) {
      log("EEEEE>::::::::::::::::::::::::::: $e");
      emit(FilterErrorState(message: 'Something went wrong'));
    }
  }
}
