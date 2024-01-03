import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instacoach/logic/cubits/avaibility_cubit/get_availibility_cubit/get_availibility_state.dart';

import '../../../../domain/repositories/api_repositories.dart';



class GetAvailibilityCubit extends Cubit<GetAvailibilityState> {
  GetAvailibilityCubit(this.apiServices) : super(GetAvailibilityLoadingState());

  ApiServices apiServices;

  Future loadavailibilities(String coachId) async {
    try {
    emit(GetAvailibilityLoadingState());
      final data = await apiServices.getAvailibilityRespository(coachId);
      log("data:::::::::::::::::::::::::::::::::::::::::: ${data.data!.data}");
      if (data.data!.data!.coachCalAvailabilityData != null) {
        emit(GetAvailibilityLoadedState(data.data!));
        log("Data is comming ");
      } 
    } catch (e) {
      log("EEEEE>::::::::::::::::::::::::::: $e");
      emit(const ErrorState('Something went wrong'));
    }
  }
}
