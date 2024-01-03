part of 'create_availibility_bloc.dart';

class CreateAvailibilityState extends Equatable {
  const CreateAvailibilityState();

  @override
  List<Object> get props => [];
}

class CreateAvailibilityInitialState extends CreateAvailibilityState {
  @override
  List<Object> get props => [];
}

class CreateAvailibilityLoadingState extends CreateAvailibilityState {
  @override
  List<Object> get props => [];
}

class CreateAvailibilityCreatedState extends CreateAvailibilityState {
  final AvailibilityModel availibilty;

  const CreateAvailibilityCreatedState(this.availibilty);
  @override
  List<Object> get props => [availibilty];
}



class CreateAvailibilityErrorState extends CreateAvailibilityState {
  final String message;

  const CreateAvailibilityErrorState(this.message);
  @override
  List<Object> get props => [message];
}
