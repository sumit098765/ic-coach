import 'package:equatable/equatable.dart';
import 'package:instacoach/domain/models/profile_model/upload_profile_model.dart';


class UploadPPState extends Equatable {
  const UploadPPState();

  @override
  List<Object> get props => [];
}

class UploadPPLoadingState extends UploadPPState {
  @override
  List<Object> get props => [];
}

class UploadPPLoadedState extends UploadPPState {
  final UploadProfilePictureModel uploadProfilePictureModel;

  const UploadPPLoadedState(this.uploadProfilePictureModel);
  @override
  List<Object> get props => [uploadProfilePictureModel];
}

class UploadPPErrorState extends UploadPPState {
  final String message;

  const UploadPPErrorState(this.message);
  @override
  List<Object> get props => [message];
}
