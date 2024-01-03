import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instacoach/logic/cubits/reset_password_cubit/reset_password_cubit.dart';
import 'package:instacoach/presentation/widgets/appbar.dart';

import '../../../logic/cubits/reset_password_cubit/reset_password_state.dart';
import '../../../utils/constants/colors.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/password_feild_decoration.dart';
import '../../widgets/text_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    super.key,
    this.coachId,
    this.userId,
    required this.email,
  });

  final String? userId;
  final String? coachId;
  final String email;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController currentPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  bool currentPasswordVisible = false;
  bool newPasswordVisible = false;
  bool comfirmPasswordVisible = false;
  bool isloading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void toggleCurrentPassword() {
    setState(() {
      currentPasswordVisible = !currentPasswordVisible;
    });
  }

  void toggleNewPassword() {
    setState(() {
      newPasswordVisible = !newPasswordVisible;
    });
  }

  void toggleConfirmNewPassword() {
    setState(() {
      comfirmPasswordVisible = !comfirmPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar2(
        context: context,
        title: "",
        visible: true,
        icon: const Icon(Icons.abc),
      ),
      body: BlocListener<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordLoadedState) {
            Fluttertoast.showToast(msg: "Successfully changed");
            Navigator.pop(context);
            // PersistentNavBarNavigator.pushNewScreen(context,
            //     screen: ViewProfileScreen(
            //       coachId: widget.coachId ?? "",
            //       userId: widget.userId ?? "",
            //     ),
            //     withNavBar: true);
          } else if (state is ResetPasswordWorngEmailState) {
            Fluttertoast.showToast(
                msg:
                    state.resetPasswordModel.errorResponse!.message.toString());
          } else if (state is ResetPasswordWrongOldPasswordState) {
            Fluttertoast.showToast(
                msg:
                    state.resetPasswordModel.errorResponse!.message.toString());
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 140.sp,
                  ),
                  const TextWidget(
                    text: "Reset Password",
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: AppColors.selectedBlue,
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  buildPasswordField(
                    label: "Current Password",
                    controller: currentPassController,
                    togglePassword: toggleCurrentPassword,
                    passwordVisible: currentPasswordVisible,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),

                  buildPasswordField(
                    label: "New Password",
                    controller: newPassController,
                    togglePassword: toggleNewPassword,
                    passwordVisible: newPasswordVisible,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  // Confirm Password
                  buildPasswordField(
                    label: "Confirm Password",
                    controller: confirmPassController,
                    passwordVisible: comfirmPasswordVisible,
                    togglePassword: toggleConfirmNewPassword,
                    confirmValidator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm password is required';
                      } else if (value != newPassController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 100.sp,
                  ),
                  gradientButton1(
                    context: context,
                    rWidth: 390,
                    rHeight: 44,
                    btnText: "Reset Password",
                    color: AppColors.selectedBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    onPress: isloading
                        ? () {
                            log("Button is disabled");
                          }
                        : () async {
                            log("Button pressed");
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                isloading = true;
                              });

                              try {
                                await BlocProvider.of<ResetPasswordCubit>(
                                        context)
                                    .resetPassword(
                                  widget.email,
                                  currentPassController.text,
                                  newPassController.text,
                                );

                                //    log("API call successful");
                              } catch (error) {
                                //  log("Error: $error");
                              } finally {
                                setState(() {
                                  isloading = false;
                                });
                                log("Button enabled");
                              }
                            } else {
                              log("Form validation failed");
                            }
                          },
                  ),
                  SizedBox(
                    height: 30.sp,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPasswordField({
    required String label,
    required TextEditingController controller,
    required VoidCallback togglePassword,
    required bool passwordVisible,
    String? Function(String?)? confirmValidator,
  }) {
    bool hasLetterAndNumber(String value) {
      RegExp regex = RegExp(r'^(?=.{8,})(?=.*[a-z])(?=.*\d).*$');
      // RegExp regex = RegExp(r'^(?=.{8,})(?=.*[a-z])(?=.*[A-Z])(?=.*[^\w\d]).*$');
      return regex.hasMatch(value);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: label,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: controller,
          obscureText: !passwordVisible,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.visiblePassword,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Password is required';
            } else if (value.length < 8 && !hasLetterAndNumber(value)) {
              return 'Password must be at least 8 characters long';
            } else if (!hasLetterAndNumber(value)) {
              return 'Password must contain numeric character.';
            }

            if (confirmValidator != null) {
              return confirmValidator(value);
            }

            return null;
          },
          autofocus: false,
          decoration: passwordFieldDecoration(
            labelText: '********',
            hintTxt: '',
            togglePassword: togglePassword,
            passwordVisible: passwordVisible,
          ),
        ),
      ],
    );
  }
}
