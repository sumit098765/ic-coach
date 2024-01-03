import 'package:equatable/equatable.dart';
import 'package:instacoach/domain/models/profile_model/edit_profile_model.dart';



class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

class EditProfileLoadingState extends EditProfileState {
  @override
  List<Object> get props => [];
}

class EditProfileLoadedState extends EditProfileState {
  final EditProfileModel editProfile;

  const EditProfileLoadedState(this.editProfile);
  @override
  List<Object> get props => [editProfile];
}


class EditProfileErrorState extends EditProfileState {
  final String message;

  const EditProfileErrorState(this.message);
  @override
  List<Object> get props => [message];
}
