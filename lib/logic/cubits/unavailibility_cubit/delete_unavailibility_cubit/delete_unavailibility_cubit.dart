import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instacoach/domain/repositories/api_repositories.dart';
import 'package:instacoach/logic/cubits/unavailibility_cubit/get_unavailibility_cubit/get_unavailibility_cubit.dart';

import 'delete_unavailibility_state.dart';

class DeleteUnAvailibilityCubit extends Cubit<DeleteUnAvailibilityState> {
  DeleteUnAvailibilityCubit(this.apiServices)
      : super(DeleteUnAvailibilityLoadingState());
  ApiServices apiServices;

  Future deleteUnAvailibilities(
      String coachID,
      String date,
      int id,
      BuildContext originalContext,
      bool isUnBlocked,
      GetUnavailibilityCubit getUnavailibilityCubit) async {
    try {
      emit(DeleteUnAvailibilityLoadingState());
      final data = await apiServices.deleteUnAvailibilityRepository(
          coachID, date, id, isUnBlocked);
      log("data in delete override:::::::::::::::::::::::::::::::::::::::::: ${data.data!.data!.removeOnschedAllocationItem!.reason}");
      if (data.data!.data!.removeOnschedAllocationItem!.reason ==
          "Date Override Allocation") {
        emit(DeleteUnAvailibilityLoadedState(data.data!));
        log("deleted override ");
        await getUnavailibilityCubit.loadOverrides(false, coachID, date);
      } else if (data.data!.data!.removeOnschedAllocationItem!.reason ==
          "Date Override Block") {
        emit(DeleteUnAvailibilityUnBlockLoadedState(data.data!));
        log("deleted Unblock ");
        await getUnavailibilityCubit.loadOverrides(false, coachID, date);
      }
    } catch (e) {
      log("Error in delete UNavailibility Cubit>::::::::::::::::::::::::::: $e");
      emit(const DeleteUnAvailibilityErrorState('Something went wrong'));
    }
  }
}
