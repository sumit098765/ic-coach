import 'package:equatable/equatable.dart';

class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();

  @override
  List<Object> get props => [];
}

class ForgetPasswordInitialState extends ForgetPasswordState {
  @override
  List<Object> get props => [];
}

class ForgetPasswordLoadingState extends ForgetPasswordState {
  @override
  List<Object> get props => [];
}

class ForgetPasswordLoadedState extends ForgetPasswordState {
  final String message;

  const ForgetPasswordLoadedState(this.message);
  @override
  List<Object> get props => [message];
}

class ForgetPasswordEmailWrongState extends ForgetPasswordState {
  final String message;

  const ForgetPasswordEmailWrongState(this.message);
  @override
  List<Object> get props => [message];
}

class ForgetPasswordUserDNExistsState extends ForgetPasswordState {
  final String message;

  const ForgetPasswordUserDNExistsState(this.message);
  @override
  List<Object> get props => [message];
}

class ForgetPasswordErrorState extends ForgetPasswordState {
  final String message;

  const ForgetPasswordErrorState(this.message);
  @override
  List<Object> get props => [message];
}
