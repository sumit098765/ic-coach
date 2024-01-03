import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitialEvent extends LoginEvent {}

class LoginSuccessfulEvent extends LoginEvent {
  final String email;
  final String password;
  
  LoginSuccessfulEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}
