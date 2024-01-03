import 'package:equatable/equatable.dart';

import '../../../../domain/models/profile_model/get_profile_model.dart';

class GetProfileState extends Equatable {
  const GetProfileState();

  @override
  List<Object> get props => [];
}

class GetProfileLoadingState extends GetProfileState {
  @override
  List<Object> get props => [];
}

class GetProfileLoadedState extends GetProfileState {
  final GetProfileModel getProfile;

  const GetProfileLoadedState(this.getProfile);
  @override
  List<Object> get props => [getProfile];
}

// class GetProfileLoadedEmptyState extends GetProfileState {
//   final String message;

//   const GetProfileLoadedEmptyState(this.message);
//   @override
//   List<Object> get props => [message];
// }

class GetProfileErrorState extends GetProfileState {
  final String message;

  const GetProfileErrorState(this.message);
  @override
  List<Object> get props => [message];
}
