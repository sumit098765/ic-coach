import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instacoach/logic/cubits/forget_password_cubit/forget_password_cubit.dart';
import 'package:instacoach/logic/cubits/forget_password_cubit/forget_password_state.dart';
import 'package:instacoach/presentation/widgets/appbar.dart';
import 'package:instacoach/presentation/widgets/gradient_button.dart';
import 'package:instacoach/presentation/widgets/textfield_decoration.dart';
import 'package:instacoach/utils/constants/colors.dart';

import '../../../../utils/helper/validation.dart';
import '../../../widgets/text_widget.dart';
import 'forget_password_linksent_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appbar2(context: context, title: "", visible: true, icon: null),
      body: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state is ForgetPasswordLoadedState) {
            Fluttertoast.showToast(msg: state.message);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  ForgetPasswordLinkSentScreen(email: emailController.text,),
                ));
          } else if (state is ForgetPasswordEmailWrongState) {
            Fluttertoast.showToast(msg: state.message);
          } else if (state is ForgetPasswordUserDNExistsState) {
            Fluttertoast.showToast(msg: state.message);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: MediaQuery.of(context).viewInsets.bottom > 0
                          ? 100
                          : 150),
                  const TextWidget(
                    text: "Forget Password",
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: AppColors.selectedBlue,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextWidget(
                    text: "Enter your registered email below",
                    color: AppColors.darkGrey,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  buildPasswordField(
                    label: "Email",
                    controller: emailController,
                  ),
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: MediaQuery.of(context).viewInsets.bottom > 0
                          ? 75.sp
                          : 300.sp),
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
                            log("is disbaled");
                          }
                        : () async {
                            if (formKey.currentState!.validate()) {
                              log("Tapped ");
                              setState(() {
                                isloading = true;
                              });

                              try {
                                await BlocProvider.of<ForgetPasswordCubit>(
                                        context)
                                    .sentForgetPassword(emailController.text);
                              } catch (error) {
                                log("Error e");
                              } finally {
                                setState(() {
                                  isloading = false;
                                });
                              }
                            }
                          },
                  ),
                  SizedBox(
                    height: 15.sp,
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
  }) {
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
            autocorrect: false,
            enableSuggestions: false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => Validation.email(value),
            autofocus: false,
            decoration: textFieldMainDecoration(
              labelText: '',
              hintText: 'abc@example.com',
            ))
      ],
    );
  }
}
