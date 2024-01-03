import 'package:equatable/equatable.dart';

import '../../../../domain/models/auth_model/login_model.dart';


class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessfulState extends LoginState {

  final LoginModel loginModel;

  LoginSuccessfulState( this.loginModel);

  @override
  List<Object?> get props => [ loginModel];
}

class LoginUserDoesNotExistState extends LoginState {
  final String failureResponse;

  LoginUserDoesNotExistState(this.failureResponse);

  @override
  List<Object?> get props => [failureResponse];
}



class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
