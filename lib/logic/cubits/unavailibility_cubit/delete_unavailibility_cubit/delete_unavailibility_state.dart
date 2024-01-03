import 'package:equatable/equatable.dart';

import '../../../../../domain/models/availibility_model/delete_availibility_model.dart';

class DeleteUnAvailibilityState extends Equatable {
  const DeleteUnAvailibilityState();

  @override
  List<Object> get props => [];
}

class DeleteUnAvailibilityLoadingState extends DeleteUnAvailibilityState {
  @override
  List<Object> get props => [];
}

class DeleteUnAvailibilityLoadedState extends DeleteUnAvailibilityState {
  final DeleteAvailibilityModel deleteUnAvailibility;

  const DeleteUnAvailibilityLoadedState(this.deleteUnAvailibility);
  @override
  List<Object> get props => [deleteUnAvailibility];
}

class DeleteUnAvailibilityUnBlockLoadedState extends DeleteUnAvailibilityState {
  final DeleteAvailibilityModel unBlockUnAvailibility;

  const DeleteUnAvailibilityUnBlockLoadedState(this.unBlockUnAvailibility);
  @override
  List<Object> get props => [unBlockUnAvailibility];
}

class DeleteUnAvailibilityErrorState extends DeleteUnAvailibilityState {
  final String message;

  const DeleteUnAvailibilityErrorState(this.message);
  @override
  List<Object> get props => [message];
}
