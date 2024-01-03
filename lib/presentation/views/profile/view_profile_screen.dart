// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instacoach/domain/repositories/api_repositories.dart';
import 'package:instacoach/logic/cubits/profile_cubits/edit_profile_cubit.dart/edit_profile_cubit.dart';
import 'package:instacoach/presentation/views/authentication/Login.dart';
import 'package:instacoach/presentation/views/profile/reset_password_screen.dart';
import 'package:instacoach/presentation/widgets/appbar.dart';
import 'package:instacoach/presentation/widgets/text_field_widget.dart';
import 'package:instacoach/presentation/widgets/text_widget.dart';
import 'package:instacoach/utils/constants/colors.dart';
import 'package:image_picker/image_picker.dart';
import '../../../logic/cubits/profile_cubits/edit_profile_cubit.dart/edit_profile_state.dart';
import '../../../logic/cubits/profile_cubits/get_profile_cubit/get_profile_cubit.dart';
import '../../../logic/cubits/profile_cubits/get_profile_cubit/get_profile_state.dart';
import '../../../logic/cubits/profile_cubits/upload_pp_cubit/upload_pp_cubit.dart';
import '../../../logic/cubits/profile_cubits/upload_pp_cubit/upload_pp_state.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/presistent_navigation_widget.dart';

class ViewProfileScreen extends StatefulWidget {
  const ViewProfileScreen(
      {super.key, required this.userId, required this.coachId});
  final String userId;
  final String coachId;

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  @override
  void initState() {
    BlocProvider.of<GetProfileCubit>(context).loadProfile();
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final picker = ImagePicker();
  File? image;
  bool isEditMode = false;
  bool isProfileModified = false;

  bool validateNonEmptyFields() {
    if (phoneNumberController.text.isNotEmpty &&
        !RegExp(r'^[0-9]{10}$').hasMatch(phoneNumberController.text)) {
      return false;
    }
    return true;
  }

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    log("User id ${widget.userId}");
    log("Coach Id ${widget.coachId}");
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 240, 240),
      resizeToAvoidBottomInset: false,
      appBar: appbar1(
          context: context,
          title: "Profile",
          visible: false,
          icon: const Icon(
            Icons.abc,
            color: AppColors.white,
          )),
      body: BlocListener<UploadPPCubit, UploadPPState>(
        listener: (context, state) {
          if (state is UploadPPLoadedState) {
            Fluttertoast.showToast(msg: "uploaded Sucessfully");
          }
        },
        child: BlocListener<EditProfileCubit, EditProfileState>(
          listener: (context, state) {
            if (state is EditProfileLoadedState) {
              Fluttertoast.showToast(msg: "Edited Sucessfully");
            }
          },
          child: BlocBuilder<GetProfileCubit, GetProfileState>(
            builder: (context, state) {
              if (state is GetProfileLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.black,
                  ),
                );
              } else if (state is GetProfileLoadedState) {
                final profile = state.getProfile.data!.user!;
                log("${profile.address}");
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(35)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 10),
                                    child: isEditMode
                                        ? CircleAvatar(
                                            backgroundColor:
                                                AppColors.lightBlue,
                                            radius: 50,
                                            child: InkWell(
                                              onTap: () {
                                                imagePickOptions(context);
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/Landscape.png",
                                                    height: 30,
                                                  ),
                                                  const TextWidget(
                                                      text: "Upload\nPhoto")
                                                ],
                                              ),
                                            ),
                                          )
                                        : CircleAvatar(
                                            backgroundColor:
                                                AppColors.lightBlue,
                                            radius: 50,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Image.network(
                                                profile.avatar.toString(),
                                                fit: BoxFit.fill,
                                                width: 150,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return CircleAvatar(
                                                    radius: 50,
                                                    child: SvgPicture.asset(
                                                      "assets/images/pH.svg",
                                                      fit: BoxFit.fill,
                                                      width: 150,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextFieldWidget(
                                          textEditingController: nameController,
                                          isPass: false,
                                          //  hintText: "User name",
                                          labelText:
                                              // isEditMode
                                              //     ? "User Name"
                                              //     :
                                              profile.name.toString(),
                                          editMode: isEditMode,
                                          textInputType: TextInputType.name,
                                          onChanged: (value) {
                                            setState(() {
                                              isProfileModified = true;
                                            });
                                          },
                                        ),

                                        const Divider(
                                          thickness: 1,
                                          color: AppColors.lightBlue,
                                        ),
                                        TextFieldWidget(
                                          textEditingController:
                                              phoneNumberController,
                                          isPass: false,
                                          //   hintText: "Phone number",
                                          labelText:
                                              //  isEditMode
                                              //     ? "+1 555 555 5555"
                                              //     :
                                              profile.phoneNumber == "null" ||
                                                      profile.phoneNumber ==
                                                          null
                                                  ? "Phone number"
                                                  : profile.phoneNumber
                                                      .toString(),
                                          validator: (value) {
                                            if (value != null &&
                                                value.isNotEmpty) {
                                              if (!RegExp(r'^[0-9]{10}$')
                                                  .hasMatch(value.toString())) {
                                                return 'Please enter a valid 10-digit phone number';
                                              }
                                            }
                                            return "";
                                          },
                                          editMode: isEditMode,
                                          textInputType: TextInputType.number,
                                          onChanged: (value) {
                                            setState(() {
                                              isProfileModified = true;
                                            });
                                          },
                                        ),
                                        // TextWidget(text: profile.phoneNumber.toString()),

                                        const Divider(
                                          thickness: 1,
                                          color: AppColors.lightBlue,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextWidget(
                                          text: profile.email.toString(),
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Divider(
                                          thickness: 1,
                                          color: AppColors.lightBlue,
                                        ),

                                        TextFieldWidget(
                                          textEditingController:
                                              addressController,
                                          isPass: false,
                                          // hintText: "Address",
                                          labelText:
                                              //  isEditMode
                                              //     ? "Address"
                                              //     :
                                              profile.address == "null" ||
                                                      profile.address == null
                                                  ? "Address"
                                                  : profile.address.toString(),
                                          editMode: isEditMode,
                                          textInputType: TextInputType.text,
                                          onChanged: (value) {
                                            setState(() {
                                              isProfileModified = true;
                                            });
                                          },
                                        ),
                                        // TextWidget(text: profile.address.toString()),

                                        const Divider(
                                          thickness: 1,
                                          color: AppColors.lightBlue,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),

                                        gradientButton1(
                                          context: context,
                                          rWidth: 390,
                                          rHeight: 44,
                                          btnText: isEditMode
                                              ? "Save & Update"
                                              : "Edit Profile",
                                          txtColor: isEditMode
                                              ? AppColors.white
                                              : AppColors.black,
                                          color: isEditMode
                                              ? AppColors.selectedBlue
                                              : AppColors.lightGrey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          onPress: () {
                                            if (isEditMode) {
                                              if (validateNonEmptyFields()) {
                                                BlocProvider.of<
                                                            EditProfileCubit>(
                                                        context)
                                                    .editProfile(
                                                        widget.userId,
                                                        nameController.text ==
                                                                ""
                                                            ? profile.name
                                                                .toString()
                                                            : nameController
                                                                .text,
                                                        phoneNumberController
                                                                    .text ==
                                                                ""
                                                            ? profile
                                                                .phoneNumber
                                                                .toString()
                                                            : phoneNumberController
                                                                .text,
                                                        addressController
                                                                    .text ==
                                                                ""
                                                            ? profile.address
                                                                .toString()
                                                            : addressController
                                                                .text);
                                                Future.delayed(
                                                    const Duration(seconds: 1));
                                                BlocProvider.of<
                                                            GetProfileCubit>(
                                                        context)
                                                    .loadProfile();

                                                setState(() {
                                                  isEditMode = false;
                                                  isProfileModified = false;
                                                });
                                              }
                                            } else {
                                              log("ispressed");
                                              setState(() {
                                                isEditMode = true;
                                              });
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            gradientButton1(
                                context: context,
                                rWidth: 290.sp,
                                rHeight: 44,
                                btnText: "Reset Password",
                                color: AppColors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                onPress: () async {
                                  presistentNavigationWidget(
                                      context,
                                      ResetPasswordScreen(
                                        coachId: widget.coachId,
                                        userId: widget.userId,
                                        email: profile.email.toString(),
                                      ));
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  BlocProvider.of<GetProfileCubit>(context)
                                      .loadProfile();
                                }),
                            SizedBox(
                              height: 5.sp,
                            ),
                            gradientButton1(
                                context: context,
                                rWidth: 290.sp,
                                rHeight: 44,
                                btnText: "Logout",
                                color: AppColors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                onPress: () async {
                                  showModalBottomSheet(
                                    useRootNavigator: true,
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        color: AppColors.white,
                                        child: SizedBox(
                                            height: 335.sp,
                                            child: Center(
                                                child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 28,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20),
                                                    child: TextWidget(
                                                      text: "Confirm logout?",
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                const Divider(
                                                  thickness: 1,
                                                  color: AppColors.lightBlue,
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Image.asset(
                                                  "assets/images/logout.png",
                                                  height: 44,
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                TextWidget(
                                                  text: "Are you sure want to",
                                                  fontSize: 15.sp,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                TextWidget(
                                                  text: "  Logout?",
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20),
                                                  child: gradientButton1(
                                                      context: context,
                                                      rWidth: 390,
                                                      rHeight: 44,
                                                      btnText: "Cancel",
                                                      color:
                                                          AppColors.lightGrey,
                                                      fontSize: 15,
                                                      txtColor: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      onPress: () {
                                                        Navigator.pop(context);
                                                      }),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20),
                                                  child: gradientButton1(
                                                      context: context,
                                                      rWidth: 390,
                                                      rHeight: 44,
                                                      btnText: "Logout",
                                                      color: AppColors.red,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      onPress: isloading
                                                          ? () {
                                                              log("Button is disabled");
                                                            }
                                                          : () async {
                                                              FlutterSecureStorage
                                                                  storage =
                                                                  const FlutterSecureStorage();
                                                              if (await storage
                                                                  .containsKey(
                                                                      key:
                                                                          "token")) {
                                                                setState(() {
                                                                  isloading =
                                                                      true;
                                                                });

                                                                try {
                                                                  storage.delete(
                                                                      key:
                                                                          'token');
                                                                  final deviceFcmToken =
                                                                      await storage
                                                                          .read(
                                                                              key: "fcmtoken");
                                                                  storage.delete(
                                                                      key:
                                                                          'fcmtoken');
                                                                  await ApiServices().deleteFCMTokensRepository(
                                                                      widget
                                                                          .coachId,
                                                                      deviceFcmToken
                                                                          .toString());
                                                                  Fluttertoast
                                                                      .showToast(
                                                                          msg:
                                                                              "Logged Out");
                                                                  Navigator.of(
                                                                          context,
                                                                          rootNavigator:
                                                                              true)
                                                                      .pushAndRemoveUntil(
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return const LoginScreen();
                                                                      },
                                                                    ),
                                                                    (_) =>
                                                                        false,
                                                                  );
                                                                } catch (error) {
                                                                  log("Error: $error");
                                                                } finally {
                                                                  setState(() {
                                                                    isloading =
                                                                        false;
                                                                  });
                                                                  log("Button enabled");
                                                                }
                                                              }
                                                            }),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                )
                                              ],
                                            ))),
                                      );
                                    },
                                  );
                                }),
                            SizedBox(
                              height: 10.sp,
                            ),
                          ],
                        )),
                  ),
                );
              } else if (state is GetProfileErrorState) {
                return const TextWidget(text: "Something went wrong");
              } else {
                return const TextWidget(text: "");
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> imagePickOptions(BuildContext context) {
    return showModalBottomSheet<void>(
      useRootNavigator: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            height: 220.sp,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextWidget(
                  text: "Edit Profile Picture",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 15),
                const Divider(
                  thickness: 1,
                  color: AppColors.lightBlue,
                ),
                const SizedBox(height: 20),
                InkWell(
                    onTap: () {
                      pickImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    child: TextWidget(
                      text: "Take a photo",
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                    )),
                const SizedBox(height: 30),
                InkWell(
                    onTap: () {
                      pickImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    child: TextWidget(
                      text: "Pick from gallery",
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                    )),
                const SizedBox(height: 30),
                gradientButton1(
                    context: context,
                    rWidth: 350.sp,
                    rHeight: 44,
                    btnText: "close",
                    color: AppColors.selectedBlue,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    onPress: () {
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        );
      },
    );
  }

  pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(
      source: source,
      maxHeight: 300,
      maxWidth: 300,
    );
    try {
      if (pickedFile != null) {
        setState(() {
          image = File(pickedFile.path);
        });
        BlocProvider.of<UploadPPCubit>(context)
            .uploadProfilePicture(image!.path, widget.userId);
        await Future.delayed(const Duration(seconds: 2));

        BlocProvider.of<GetProfileCubit>(context).loadProfile();
        log("image:::::::::::::::::::::::::: $image");
      }
    } catch (e) {
      //   log("e  : $e");
    }
  }
}
