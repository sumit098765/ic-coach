import 'package:equatable/equatable.dart';

import '../../../../domain/models/availibility_model/get_availibility_model.dart';

class GetAvailibilityState extends Equatable {
  const GetAvailibilityState();

  @override
  List<Object> get props => [];
}

class GetAvailibilityInitial extends GetAvailibilityState {}

class GetAvailibilityLoadingState extends GetAvailibilityState {}

class GetAvailibilityLoadedState extends GetAvailibilityState {
  final GetAvailibilityModel availibility;

  const GetAvailibilityLoadedState(this.availibility);
  @override
  List<Object> get props => [availibility];
}

class ErrorState extends GetAvailibilityState {
  final String message;
  const ErrorState(this.message);
}
