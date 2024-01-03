import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instacoach/domain/repositories/api_repositories.dart';
import 'package:instacoach/logic/cubits/reset_password_cubit/reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this.apiServices) : super(ResetPasswordInitialState());
  ApiServices apiServices;

  Future<void> resetPassword(
    String email,
    String oldPassword,
    String newPassword,
  ) async {
    try {
      emit(ResetPasswordLoadingState());

      final data = await apiServices.resetPasswordRepository(
        email,
        oldPassword,
        newPassword,
      );

      if (data.data != null) {
        if (data.data!.data != null && data.data!.data!.success == true) {
          emit(ResetPasswordLoadedState(data.data!));
          log("loaded state ");
        } else if (data.data!.errorResponse != null &&
            data.data!.errorResponse!.message == "Unauthorized") {
          emit(ResetPasswordWorngEmailState(data.data!));
          log("wrong email loaded");
        } else if (data.data!.errorResponse != null &&
            data.data!.errorResponse!.message ==
                "Incorrect old password, please try again") {
          emit(ResetPasswordWrongOldPasswordState(data.data!));
          log("wrong old pass loaded");
        } else {
          emit(ResetPasswordWorngEmailState(data.data!));
          log("wrong email loaded");
        }
      } else {
        emit(const ResetPasswordErrorState('Data is null'));
      }
    } catch (e) {
      log("ResetPasswordErrorState>::::::::::::::::::::::::::: $e");
      emit(const ResetPasswordErrorState('Something went wrong'));
    }
  }
}
