// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:instacoach/logic/cubits/google_login_cubit/google_login_cubit.dart';
import 'package:instacoach/presentation/views/authentication/forget_password/forrget_password_screen.dart';
import 'package:instacoach/presentation/widgets/text_widget.dart';
import '../../../logic/blocs/authentication_bloc/LoginUserBloc/login_user_bloc.dart';
import '../../../logic/blocs/authentication_bloc/LoginUserBloc/login_user_event.dart';
import '../../../logic/blocs/authentication_bloc/LoginUserBloc/login_user_state.dart';
import '../../../logic/cubits/google_login_cubit/google_login_state.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helper/validation.dart';
import '../../widgets/bottom_navigationbar_widget.dart';
import '../../widgets/google_button_widget.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/password_feild_decoration.dart';
import '../../widgets/textfield_decoration.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  bool passwordVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  FlutterSecureStorage storage = const FlutterSecureStorage();
  Future saveIds(String coachId, String userId) async {
    await storage.write(key: "coachId", value: coachId);
    await storage.write(key: "userId", value: userId);
  }

  Future<void> readAndNavigate(BuildContext context) async {
    String? coachId = await storage.read(key: "coachId");
    String? userId = await storage.read(key: "userId");

    if (coachId != null && userId != null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => BottomNavigationBarWidget(
              key: ValueKey(coachId + userId),
              coachID: coachId,
              userId: userId,
            ),
          ),
          (route) => false);
    } else {}
  }

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final formKey1 = GlobalKey<FormState>();

  final msg = BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
    if (state is LoginLoadingState) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.black,
        ),
      );
    } else {
      return Container();
    }
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<GoogleLoginCubit, GoogleLoginState>(
      listener: (context, state) {
        if (state is GoogleAuthenticatedState) {
          saveIds(state.user.user.coachId, state.user.user.id).then((value){
            Fluttertoast.showToast(msg: "Logged in");
            readAndNavigate(context);
          });
        } else if (state is GoogleUnauthenticatedState) {
          Fluttertoast.showToast(msg: state.message);
        } else if (state is GoogleErrorState) {
          Fluttertoast.showToast(msg: "User is not a coach");
        }
      },
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessfulState) {
            saveIds(state.loginModel.data!.user.coachId,
                state.loginModel.data!.user.id).then((value){
                  Fluttertoast.showToast(msg: "Logged in");
                  readAndNavigate(context);
                });
          } else if (state is LoginUserDoesNotExistState) {
            Fluttertoast.showToast(msg: state.failureResponse);
          } else if (state is LoginErrorState) {
            Fluttertoast.showToast(msg: state.message);
          }
        },
        child: Form(
          key: formKey1,
          child: Scaffold(
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 140.0,
                        ),
                        const TextWidget(
                          text: "Instacoach",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const TextWidget(
                          text: 'Hi, Welcome back!',
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.selectedBlue,
                        ),
                        const SizedBox(
                          height: 60.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextWidget(
                              text: "Email",
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              key: const Key("emailTextField"),
                              controller: emailController,
                              autocorrect: false, 
                              enableSuggestions: false, 
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) => Validation.email(value!),
                              autofocus: false,
                              decoration: textFieldMainDecoration(
                                hintText: '',
                                labelText: '',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextWidget(
                              text: "Password",
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              key: const Key("passwordTextField"),
                              controller: passwordController,
                              obscureText: !passwordVisible,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) => Validation.password(value),
                              autofocus: false,
                              decoration: passwordFieldDecoration(
                                labelText: '',
                                hintTxt: '',
                                togglePassword: togglePassword,
                                passwordVisible: passwordVisible,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ForgetPasswordScreen(),
                                    ));
                              },
                              child: const TextWidget(
                                text: "Forgot Password?",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.selectedBlue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        gradientButton1(
                            context: context,
                            rWidth: 390,
                            rHeight: 44,
                            btnText: "Login",
                            color: AppColors.selectedBlue,
                            onPress: () {
                              log("isTapped");
                              if (formKey1.currentState!.validate()) {
                                BlocProvider.of<LoginBloc>(context).add(
                                    LoginSuccessfulEvent(emailController.text,
                                        passwordController.text));
                              }
                            },
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                        SizedBox(
                          height: 20.sp,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                color: Color.fromARGB(255, 198, 198, 198),
                                thickness: 1,
                                height: 20,
                              ),
                            ),
                            TextWidget(
                              text: '    or    ',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            Expanded(
                              child: Divider(
                                color: Color.fromARGB(255, 198, 198, 198),
                                thickness: 1,
                                height: 20,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.sp,
                        ),
                        GoogleBtn1(
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            final googleLogin =
                                context.read<GoogleLoginCubit>();
                            googleLogin.signInWithGoogle();
                          },
                        )
                      ],
                    ),
                  ),
                ),
                msg,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
