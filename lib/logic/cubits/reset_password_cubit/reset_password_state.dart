import 'package:equatable/equatable.dart';
import 'package:instacoach/domain/models/auth_model/reset_password_model.dart';

class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

class ResetPasswordInitialState extends ResetPasswordState {
  @override
  List<Object> get props => [];
}

class ResetPasswordLoadingState extends ResetPasswordState {
  @override
  List<Object> get props => [];
}

class ResetPasswordLoadedState extends ResetPasswordState {
  final ResetPasswordModel resetPasswordModel;

  const ResetPasswordLoadedState(this.resetPasswordModel);
  @override
  List<Object> get props => [resetPasswordModel];
}

class ResetPasswordWorngEmailState extends ResetPasswordState {
  final ResetPasswordModel resetPasswordModel;

  const ResetPasswordWorngEmailState(this.resetPasswordModel);
  @override
  List<Object> get props => [resetPasswordModel];
}

class ResetPasswordWrongOldPasswordState extends ResetPasswordState {
  final ResetPasswordModel resetPasswordModel;

  const ResetPasswordWrongOldPasswordState(this.resetPasswordModel);
  @override
  List<Object> get props => [resetPasswordModel];
}

class ResetPasswordErrorState extends ResetPasswordState {
  final String message;

  const ResetPasswordErrorState(this.message);
  @override
  List<Object> get props => [message];
}
