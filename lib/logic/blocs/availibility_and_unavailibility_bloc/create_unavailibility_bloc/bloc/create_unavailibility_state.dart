import 'package:equatable/equatable.dart';
import 'package:instacoach/domain/models/unavailibility_models/create_unavailibility_model.dart';

class CreateUnavailibilityState extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateUnavailibilityInitialState extends CreateUnavailibilityState {
  @override
  List<Object> get props => [];
}

class CreateUnavailibilityLoadingState extends CreateUnavailibilityState {
  @override
  List<Object> get props => [];
}

class CreateUnavailibilityLoadedState extends CreateUnavailibilityState {
  final CreateOverrideModel overrides;
  bool showBottomSheet;
  CreateUnavailibilityLoadedState(this.overrides,
      {this.showBottomSheet = false});

  @override
  List<Object> get props => [overrides, showBottomSheet];
}

class CreateUnavailibilityForWholeDayLoadedState
    extends CreateUnavailibilityState {
  final CreateOverrideModel schedule;

  CreateUnavailibilityForWholeDayLoadedState(this.schedule);

  @override
  List<Object> get props => [schedule];
}

class CreateUnavailibilityErrorState extends CreateUnavailibilityState {
  final String message;

  CreateUnavailibilityErrorState(this.message);

  @override
  List<Object> get props => [message];
}
