import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:instacoach/domain/repositories/api_repositories.dart';

import 'get_notify_count_state.dart';

class GetNotifyCountCubit extends Cubit<GetNotifyCountState> {
  GetNotifyCountCubit(this.apiServices) : super(GetNotifyCountInitialState());
  ApiServices apiServices;

  Future loadNotifyCount(String coachId) async {
    emit(GetNotifyCountLoadingState());
    try {
      final data = await apiServices
          .getCoachUnseenNotificationsCountRespository(coachId);
      log("data Get count notify:::::::::::::::::::::::::::::::::::::::::: ${data.data!.data}");
      if (data.data!.data.count.isNotEmpty) {
        emit(GetNotifyCountLoadedState(data.data!));
        log("get notify count loaded ");
      }
    } catch (e) {
      log("in notify count::::::::::::::::::::::::::: $e");
      emit(const GetNotifyCountErrorState('Something went wrong'));
    }
  }
}
