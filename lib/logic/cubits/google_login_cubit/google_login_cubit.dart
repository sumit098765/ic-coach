import 'dart:developer';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../domain/repositories/api_repositories.dart';
import 'google_login_state.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GoogleLoginCubit extends Cubit<GoogleLoginState> {
  ApiServices services;
  GoogleLoginCubit(this.services) : super(GoogleLoginInitialState());

  Future signInWithGoogle() async {
    final googleSignIn = GoogleSignIn(
        // scopes: [
        //   'email',
        //   "https://www.googleapis.com/auth/userinfo.profile",
        //   "openid"
        // ],
        clientId: Platform.isIOS ? dotenv.env['IOS_GOOGLE_CLIENT_ID'] : "",
        serverClientId: dotenv.env['WEB_GOOGLE_CLIENT_ID']
        );
    try {
      final result = await googleSignIn.signIn();
      final ggAuth = await result?.authentication;
      var token = ggAuth?.idToken;
      log("iD Token ${token!.isNotEmpty}");
      if (token.isNotEmpty) {
        log("after if is true");
        
        final data = await services.gooleloginRepository(
            "hello", token, "null");
            log("data $data");
            log("token from response  ${data.data!.token}");
        if (data.data?.user.verified == true) {
          emit(GoogleAuthenticatedState(data.data!));
        } else if (data.data!.user.verified == false) {
          emit(GoogleUnauthenticatedState("User is not a coach"));
        }
      }
    } catch (e) {
      log("error in google cubit${e.toString()}");
      emit(GoogleErrorState(e.toString()));
    }
  }
}
