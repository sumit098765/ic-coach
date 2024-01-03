import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/repositories/api_repositories.dart';
import 'get_unavailibility_state.dart';

class GetUnavailibilityCubit extends Cubit<GetUnavailibilityState> {
  GetUnavailibilityCubit(this.apiServices)
      : super(GetUnavailibilityLoadingState());
  ApiServices apiServices;

  Future loadOverrides(
    bool showBottomSheet,
    String coachId,
    String selectedDate,
  ) async {
    emit(GetUnavailibilityLoadingState());
    log ("selected date inside loadOverrides cubit $selectedDate");
    try {
      final data =
          await apiServices.getUnAvailibilityRespository(coachId, selectedDate);
      log("data Get unavilable:::::::::::::::::::::::::::::::::::::::::: ${data.data!.data}");
      if (data.data?.data?.allots.allotMap != null) {
        emit(GetUnavailibilityLoadedState(data.data!,showBottomSheet: showBottomSheet));
        log("get Unavailable loaded ");
      } else {
        emit(const GetUnavailibilityLoadedEmptyState(""));
      }
    } catch (e) {
      log("EEEEE>::::::::::::::::::::::::::: $e");
      emit(const GetUnavailibilityErrorState('Something went wrong'));
    }
  }
}
