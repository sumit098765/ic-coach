import 'package:equatable/equatable.dart';

import '../../../../../domain/models/availibility_model/delete_availibility_model.dart';

class DeleteAvailibilityState extends Equatable {
  const DeleteAvailibilityState();

  @override
  List<Object> get props => [];
}

class DeleteAvailibilityLoadingState extends DeleteAvailibilityState {
  @override
  List<Object> get props => [];
}

class DeleteAvailibilityLoadedState extends DeleteAvailibilityState {
  final DeleteAvailibilityModel deleteAvailibility;

  const DeleteAvailibilityLoadedState(this.deleteAvailibility);
  @override
  List<Object> get props => [deleteAvailibility];
}

class DeleteAvailibilityErrorState extends DeleteAvailibilityState {
  final String message;

  const DeleteAvailibilityErrorState(this.message);
  @override
  List<Object> get props => [message];
}
