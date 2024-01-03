import 'package:flutter/material.dart';
import 'package:instacoach/presentation/views/authentication/Login.dart';
import 'package:instacoach/presentation/widgets/gradient_button.dart';
import 'package:instacoach/presentation/widgets/password_feild_decoration.dart';
import 'package:instacoach/presentation/widgets/text_widget.dart';
import 'package:instacoach/utils/constants/colors.dart';

import '../../../../utils/helper/validation.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController newPassController = TextEditingController();

  TextEditingController confirmPassController = TextEditingController();

  bool passwordVisible = false;

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 180,
              ),
              const TextWidget(
                text: "Change Password",
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: AppColors.selectedBlue,
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWidget(
                    text: "New Password",
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                      controller: newPassController,
                      obscureText: !passwordVisible,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) => Validation.password(value),
                      autofocus: false,
                      decoration: passwordFieldDecoration(
                        labelText: '********',
                        hintTxt: '********',
                        togglePassword: togglePassword,
                        passwordVisible: passwordVisible,
                      )),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWidget(
                    text: "Confirm Password",
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                      controller: confirmPassController,
                      obscureText: !passwordVisible,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) => Validation.password(value),
                      autofocus: false,
                      decoration: passwordFieldDecoration(
                        labelText: '********',
                        hintTxt: '********',
                        togglePassword: togglePassword,
                        passwordVisible: passwordVisible,
                      )),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     switchWidget(
              //       switchColor: AppColors.green,
              //       switchText: 'Remember me',
              //     ),
              //   ],
              // ),
              const Expanded(child: SizedBox()),
              gradientButton1(
                  context: context,
                  rWidth: 390,
                  rHeight: 44,
                  btnText: "Save Password",
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
                height: 15,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
