import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/repositories/api_repositories.dart';
import 'get_profile_state.dart';

class GetProfileCubit extends Cubit<GetProfileState> {
  GetProfileCubit(this.apiServices) : super(GetProfileLoadingState());
  ApiServices apiServices;

  Future loadProfile() async {
    emit(GetProfileLoadingState());
    try {
      final data = await apiServices.getProfileRespository();
      log("data Get profile:::::::::::::::::::::::::::::::::::::::::: ${data.data!.data}");
      if (data.data?.data!.user != null) {
        emit(GetProfileLoadedState(data.data!));
        log("get profile loaded ");
      }
    } catch (e) {
      log("in profile>::::::::::::::::::::::::::: $e");
      emit(const GetProfileErrorState('Something went wrong'));
    }
  }
}
