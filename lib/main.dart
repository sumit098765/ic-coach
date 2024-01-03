// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:instacoach/logic/blocs/availibility_and_unavailibility_bloc/create_availibility_bloc/bloc/create_availibility_bloc.dart';
import 'package:instacoach/logic/blocs/availibility_and_unavailibility_bloc/create_unavailibility_bloc/bloc/create_unavailibility_bloc.dart';
import 'package:instacoach/logic/cubits/filter_cubit/filter_cubit.dart';
import 'package:instacoach/logic/cubits/forget_password_cubit/forget_password_cubit.dart';
import 'package:instacoach/logic/cubits/get_all_reservation_cubit/get_all_reservations_cubit.dart';
import 'package:instacoach/logic/cubits/google_login_cubit/google_login_cubit.dart';
import 'package:instacoach/logic/cubits/notification_cubit/get_notify_count_cubit/get_notify_count_cubit.dart';
import 'package:instacoach/logic/cubits/notification_cubit/get_notify_cubit/get_notify_cubit.dart';
import 'package:instacoach/logic/cubits/profile_cubits/edit_profile_cubit.dart/edit_profile_cubit.dart';
import 'package:instacoach/logic/cubits/profile_cubits/get_profile_cubit/get_profile_cubit.dart';
import 'package:instacoach/logic/cubits/profile_cubits/upload_pp_cubit/upload_pp_cubit.dart';
import 'package:instacoach/logic/cubits/rcc_request_cubit.dart/rcc_request_cubit.dart';
import 'package:instacoach/logic/cubits/reservation_cubits/get_single_reservation_cubit/get_single_reservation_cubit.dart';
import 'package:instacoach/logic/cubits/reset_filter/reset_filter_cubit.dart';
import 'package:instacoach/logic/cubits/reset_password_cubit/reset_password_cubit.dart';
import 'package:instacoach/logic/cubits/unavailibility_cubit/delete_unavailibility_cubit/delete_unavailibility_cubit.dart';
import 'package:instacoach/logic/cubits/unavailibility_cubit/get_unavailibility_cubit/get_unavailibility_cubit.dart';
import 'package:instacoach/presentation/views/authentication/Login.dart';
import 'package:instacoach/presentation/widgets/bottom_navigationbar_widget.dart';
import 'domain/repositories/api_repositories.dart';
import 'logic/blocs/authentication_bloc/LoginUserBloc/login_user_bloc.dart';
import 'logic/cubits/avaibility_cubit/delete_availibility/cubit/delete_availibility_cubit.dart';
import 'logic/cubits/avaibility_cubit/get_availibility_cubit/get_availibility_cubit.dart';
import 'logic/cubits/reservation_cubits/get_package_reservation/package_reservation_cubit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

final keysToEliminate = [
  "token"
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load();
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('first_run') ?? true) {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await Future.wait(keysToEliminate.map((key) => storage.delete(key: key)));
    prefs.setBool('first_run', false);
  }
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => GetSingleReservationCubit(ApiServices()),
            ),
            BlocProvider(
              create: (context) =>
                  GetSinglePackageReservationCubit(ApiServices()),
            ),
            BlocProvider(
              create: (context) => LoginBloc(ApiServices()),
            ),
            BlocProvider(
              create: (context) => FilterCubit(ApiServices()),
            ),
            BlocProvider(
              create: (context) => GoogleLoginCubit(ApiServices()),
            ),
            BlocProvider(
              create: (context) => RCCReuestCubit(ApiServices()),
            ),
            BlocProvider(
              create: (context) => GetAllReservationCubit(ApiServices()),
            ),
            BlocProvider(
              create: (context) => CreateAvailibilityBloc(ApiServices()),
            ),
            BlocProvider(
              create: (context) => GetAvailibilityCubit(ApiServices()),
            ),
            BlocProvider(
              create: (context) => DeleteAvailibilityCubit(ApiServices()),
            ),
            BlocProvider(
              create: (context) => CreateUnavailibilityBloc(ApiServices()),
            ),
            BlocProvider(
              create: (context) => GetUnavailibilityCubit(ApiServices()),
            ),
            BlocProvider(
              create: (context) => DeleteUnAvailibilityCubit(ApiServices()),
            ),
            BlocProvider(
              create: (context) => GetProfileCubit(ApiServices()),
            ),
            BlocProvider(
              create: (context) => EditProfileCubit(ApiServices()),
            ),
            BlocProvider(
              create: (context) => ResetFilterCubit(),
            ),
            BlocProvider(
              create: (context) => UploadPPCubit(ApiServices()),
            ),
            BlocProvider(
              create: (context) => GetNotifyCubit(ApiServices()),
            ),
            BlocProvider(
              create: (context) => GetNotifyCountCubit(ApiServices()),
            ),
              BlocProvider(
              create: (context) => ForgetPasswordCubit(ApiServices()),
            ),
             BlocProvider(
              create: (context) => ResetPasswordCubit(ApiServices()),
            )
          ],
          child: MaterialApp(
              home: const StartPage(),
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white, fontFamily: 'Roboto')),
          // initialRoute: '/',
          // routes: {
          //   '/': (context) => const StartPage(),
          //   '/login': (context) => const LoginScreen(),
          //   '/forgetPasswordScreen': (context) => ForgetPasswordScreen(),
          //   '/forgetPasswordLinkSentScreen': (context) =>
          //       const ForgetPasswordLinkSentScreen(),
          //   '/changePasswordScreen': (context) =>
          //       const ChangePasswordScreen(),
          //   '/reservationScreen': (context) => ReservationScreen(),
          //   '/reservationDetailScreen': (context) =>
          //       const ReservationDetailScreen(),
          //   '/avaiAndUnAvaiScreen': (context) =>
          //       const AvaiAndUnAvaiScreen(),
          //   '/profileScreen': (context) => const ViewProfileScreen(),
          //   '/resetPasswordScreen': (context) =>
          //       const ResetPasswordScreen(),
          // },
        );
      },
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  FlutterSecureStorage s = const FlutterSecureStorage();
  @override
  void initState() {
    getToken();
    super.initState();
  }

  getToken() async {
    String? token = await s.read(key: 'token');
    String? coachId = await s.read(key: "coachId");
    String? userId = await s.read(key: "userId");
    log("coachId $coachId");
    log("userId $userId ");
    if (token != null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (BuildContext context) => BottomNavigationBarWidget(
                  coachID: coachId,
                  userId: userId,
                )),
        (Route<dynamic> route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SizedBox(), resizeToAvoidBottomInset: false);
  }
}
