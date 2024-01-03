import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instacoach/logic/cubits/profile_cubits/edit_profile_cubit.dart/edit_profile_state.dart';

import '../../../../domain/repositories/api_repositories.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this.apiServices) : super(EditProfileLoadingState());
  ApiServices apiServices;

  Future editProfile(
    String userId,
    String name,
    String phoneNumber,
    String address,
  ) async {
    emit(EditProfileLoadingState());
    try {
      final data = await apiServices.editProfileRepository(
          userId, name, phoneNumber, address);
      log("data EDIT profile:::::::::::::::::::::::::::::::::::::::::: ${data.data!.data}");
      if (data.data?.data.user != null) {
        emit(EditProfileLoadedState(data.data!));
        log("EDIT profile loaded ");
      }
    } catch (e) {
      log("EDIT profile>::::::::::::::::::::::::::: $e");
      emit(const EditProfileErrorState('Something went wrong'));
    }
  }
}
