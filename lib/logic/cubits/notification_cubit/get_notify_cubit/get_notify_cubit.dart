import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instacoach/domain/repositories/api_repositories.dart';

import 'get_notify_state.dart';

class GetNotifyCubit extends Cubit<GetNotifyState> {
  GetNotifyCubit(this.apiServices) : super(GetNotifyInitialState());
  ApiServices apiServices;
  Future loadNotify(String coachId) async {
    emit(GetNotifyLoadingState());
    try {
      final data = await apiServices.getCoachNotificationsRespository(coachId);
      log("data Get notify:::::::::::::::::::::::::::::::::::::::::: ${data.data!.data}");
      if (data.data!.data.notifications.isNotEmpty) {
        emit(GetNotifyLoadedState(data.data!));
        log("get notify loaded ");
      } else if (data.data!.data.notifications.isEmpty) {
        emit(const GetNotifyEmptyState("message"));
      }
    } catch (e) {
      log("in notify>::::::::::::::::::::::::::: $e");
      emit(const GetNotifyErrorState('Something went wrong'));
    }
  }
}
