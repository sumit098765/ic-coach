import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/repositories/api_repositories.dart';
import 'login_user_event.dart';
import 'login_user_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  ApiServices apiServices;

  LoginBloc(this.apiServices) : super(LoginInitialState()) {
    on<LoginInitialEvent>((event, emit) => emit(LoginInitialState()));
    on<LoginSuccessfulEvent>((event, emit) async {
      emit(LoginLoadingState());
      try {
        final data =
            await apiServices.loginRepository(event.email, event.password);
        log("data $data");
        if (data.data?.data != null) {
          emit(LoginSuccessfulState(data.data!));
        } 
        else if (data.data?.errorResponse != null) {
          log("Before success");
          emit(LoginUserDoesNotExistState(data.data!.errorResponse!.message));
          log("after success");
        }
      } catch (e) {
        log("Error in Bloc::::::::: $e");
        emit(LoginErrorState(e.toString()));
      }
    });
  }
}
