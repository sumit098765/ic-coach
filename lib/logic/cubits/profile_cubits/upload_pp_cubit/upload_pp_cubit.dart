import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instacoach/logic/cubits/profile_cubits/upload_pp_cubit/upload_pp_state.dart';

import '../../../../domain/repositories/api_repositories.dart';

class UploadPPCubit extends Cubit<UploadPPState> {
  UploadPPCubit(this.apiServices) : super(UploadPPLoadingState());
  ApiServices apiServices;

  Future uploadProfilePicture(String imagePath, String id) async {
    emit(UploadPPLoadingState());
    try {
      final data = await apiServices.uploadPPRespository(imagePath, id);
      log("data Upload profile:::::::::::::::::::::::::::::::::::::::::: ${data.data!}");
      if (data.data!.message == "success") {
        emit(UploadPPLoadedState(data.data!));
        log("Upload profile loaded ");
       
      }
    } catch (e) {
      log("Upload profile>::::::::::::::::::::::::::: $e");
      emit(const UploadPPErrorState('Something went wrong'));
    }
  }
}
