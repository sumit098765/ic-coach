import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instacoach/domain/repositories/api_repositories.dart';

import '../../get_availibility_cubit/get_availibility_cubit.dart';
import 'delete_availibility_state.dart';

class DeleteAvailibilityCubit extends Cubit<DeleteAvailibilityState> {
  DeleteAvailibilityCubit(this.apiServices)
      : super(DeleteAvailibilityLoadingState());
  ApiServices apiServices;

  Future deleteAvailibilities(
      int allocationId, BuildContext originalContext, String coachId) async {
    try {
      //emit(GetAllReservationLoadingState());
      final data = await apiServices.deleteAvailibilityRepository(
        allocationId,
      );
      log("data:::::::::::::::::::::::::::::::::::::::::: ${data.data!.data}");
      if (data.data!.data!.removeOnschedAllocationItem!.deletedStatus == true) {
        emit(DeleteAvailibilityLoadedState(data.data!));
        log("deleted allocation");
        BlocProvider.of<GetAvailibilityCubit>(originalContext)
            .loadavailibilities(coachId);
            
      }
    } catch (e) {
      log("Error in delete availibility Cubit>::::::::::::::::::::::::::: $e");
      emit(const DeleteAvailibilityErrorState('Something went wrong'));
    }
  }
}
