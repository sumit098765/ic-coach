import 'package:equatable/equatable.dart';

import '../../../domain/models/auth_model/google_login_model.dart';

abstract class GoogleLoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class GoogleLoginInitialState extends GoogleLoginState {}

class GoogleAuthenticatedState extends GoogleLoginState {
  final GoogleLoginModel user;

  GoogleAuthenticatedState(this.user);

  @override
  List<Object> get props => [user];
}

class GoogleUnauthenticatedState extends GoogleLoginState {
  final String message;
  GoogleUnauthenticatedState(this.message);
  @override
  List<Object> get props => [message];
}

class GoogleErrorState extends GoogleLoginState {
  final String message;
  GoogleErrorState(this.message);
  @override
  List<Object> get props => [message];
}