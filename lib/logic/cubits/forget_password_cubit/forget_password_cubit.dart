import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instacoach/domain/repositories/api_repositories.dart';

import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this.apiServices) : super(ForgetPasswordInitialState());
  ApiServices apiServices;
  Future sentForgetPassword(String email) async {
    try {
      emit(ForgetPasswordLoadingState());

      final data = await apiServices.forgetPasswordRepository(email);
      log("data:::::::::::::::::::::::::::::::::::::::::: ${data.data.toString()}");
      if (data.data.toString() == "OK") {
        emit(const ForgetPasswordLoadedState("Link sent to your email"));
        log("loaded state ");
      } else if (data.data.message == "\"email\" must be a valid email") {
        emit(const ForgetPasswordEmailWrongState("Enter valid Email"));
        log("filter loaded");
      } else if (data.data.message == "User does not exits") {
        emit(const ForgetPasswordUserDNExistsState("User does not exists"));
      }
    } catch (e) {
      log("ForgetPasswordErrorState>::::::::::::::::::::::::::: $e");
      emit(const ForgetPasswordErrorState('Something went wrong'));
    }
  }
}
