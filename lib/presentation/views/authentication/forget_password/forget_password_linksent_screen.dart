import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instacoach/presentation/views/authentication/Login.dart';
import 'package:instacoach/presentation/widgets/appbar.dart';
import 'package:instacoach/presentation/widgets/gradient_button.dart';
import 'package:instacoach/presentation/widgets/text_widget.dart';
import 'package:instacoach/utils/constants/colors.dart';

import '../../../../logic/cubits/forget_password_cubit/forget_password_cubit.dart';
import '../../../../logic/cubits/forget_password_cubit/forget_password_state.dart';

class ForgetPasswordLinkSentScreen extends StatefulWidget {
  const ForgetPasswordLinkSentScreen({super.key, required this.email});
  final String email;
  @override
  State<ForgetPasswordLinkSentScreen> createState() =>
      _ForgetPasswordLinkSentScreenState();
}

class _ForgetPasswordLinkSentScreenState
    extends State<ForgetPasswordLinkSentScreen> {
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordLoadedState) {
       //   Fluttertoast.showToast(msg: "resubmitted");
        } else if (state is ForgetPasswordEmailWrongState) {
          Fluttertoast.showToast(msg: state.message);
        } else if (state is ForgetPasswordUserDNExistsState) {
          Fluttertoast.showToast(msg: state.message);
        }
      },
      child: Scaffold(
        appBar: appbar2(context: context, title: "", visible: true, icon: null),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Image.asset("assets/images/env.png"),
              const SizedBox(
                height: 25,
              ),
              const TextWidget(
                text: "Success",
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: AppColors.selectedBlue,
              ),
              const SizedBox(
                height: 10,
              ),
              const TextWidget(
                text: "Please check your email to \n   create a new password",
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppColors.darkGrey,
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextWidget(
                    text: "Can't get email?",
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  InkWell(
                    onTap: isloading
                        ? () {
                            log("is disbaled");
                          }
                        : () async {
                            log("Tapped ");
                            setState(() {
                              isloading = true;
                            });

                            try {
                              await BlocProvider.of<ForgetPasswordCubit>(
                                      context)
                                  .sentForgetPassword(widget.email);
                            } catch (error) {
                              log("Error e");
                            } finally {
                              setState(() {
                                isloading = false;
                              });
                            }
                          },
                    child: const TextWidget(
                      text: " Resubmit",
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: AppColors.selectedBlue,
                    ),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              gradientButton1(
                  context: context,
                  rWidth: 390,
                  rHeight: 44,
                  btnText: "Go back to login",
                  color: AppColors.selectedBlue,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ));
                  }),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
