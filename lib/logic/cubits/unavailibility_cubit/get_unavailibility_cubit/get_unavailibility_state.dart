import 'package:equatable/equatable.dart';

import '../../../../domain/models/unavailibility_models/get_unavailibility_model.dart';

class GetUnavailibilityState extends Equatable {
  const GetUnavailibilityState();

  @override
  List<Object> get props => [];
}

class GetUnavailibilityLoadingState extends GetUnavailibilityState {
  @override
  List<Object> get props => [];
}

class GetUnavailibilityLoadedState extends GetUnavailibilityState {
  final GetOverrideModel getOverrides;
  bool showBottomSheet;
   GetUnavailibilityLoadedState(this.getOverrides,{required this.showBottomSheet});
  @override
  List<Object> get props => [getOverrides];
}
class GetUnavailibilityLoadedEmptyState extends GetUnavailibilityState {
final String message;

  const GetUnavailibilityLoadedEmptyState(this.message);
  @override
  List<Object> get props => [message];
}

class GetUnavailibilityErrorState extends GetUnavailibilityState {
  final String message;

  const GetUnavailibilityErrorState(this.message);
  @override
  List<Object> get props => [message];
}
