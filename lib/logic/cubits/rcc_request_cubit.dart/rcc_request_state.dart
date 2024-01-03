import 'package:equatable/equatable.dart';


class RCCState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RCCLodaingState extends RCCState {}

class RCCLoadedState extends RCCState {
  final String message;
  RCCLoadedState(this.message);
  @override
  List<Object?> get props => [message];
}

class RCCNotScheduledNowState extends RCCState {
  final String message;

  RCCNotScheduledNowState(this.message);
  @override
  List<Object?> get props => [message];
}

class RCCErrorState extends RCCState {
  final String message;
  RCCErrorState({required this.message});
}
