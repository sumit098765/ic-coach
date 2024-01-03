// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instacoach/config/icons/my_flutter_app_icons.dart';
import 'package:instacoach/presentation/views/availibility&unavailibility/Availibility&unavailibility_screen.dart';
import 'package:instacoach/presentation/views/profile/view_profile_screen.dart';
import 'package:instacoach/utils/constants/colors.dart';
import '../views/resevation/reservation_screen.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'dart:io' show Platform;

class BottomNavigationBarWidget extends StatefulWidget {
  String? coachID;
  String? userId;
  BottomNavigationBarWidget({super.key, this.coachID, this.userId});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    // log("Coach id ${widget.coachID}");
    return [
      ReservationScreen(
        coachId: widget.coachID,
      ),
      AvaiAndUnAvaiScreen(
        coachId: widget.coachID,
      ),
      ViewProfileScreen(
          userId: widget.userId.toString(), coachId: widget.coachID.toString())
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          inactiveColorPrimary: AppColors.black,
          icon: const Icon(
            MyFlutterApp.home,
            size: 30,
          ),
          title: ("Reservations"),
          textStyle: TextStyle(fontSize: 12.sp)),
      PersistentBottomNavBarItem(
          inactiveColorPrimary: AppColors.black,
          icon: const Icon(
            MyFlutterApp.frame_134696__1_,
            size: 30,
          ),
          title: ("Calendar"),
          textStyle: TextStyle(fontSize: 12.sp)),
      PersistentBottomNavBarItem(
          inactiveColorPrimary: AppColors.black,
          icon: const Icon(
            MyFlutterApp.profile,
            size: 30,
          ),
          title: ("Profile"),
          textStyle: TextStyle(fontSize: 12.sp)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      padding: const NavBarPadding.symmetric(horizontal: 0),
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: AppColors.white,
      handleAndroidBackButtonPress: true,
      //  resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: const NavBarDecoration(boxShadow: [
        BoxShadow(color: AppColors.lightBlue, blurRadius: 1, spreadRadius: 1)
      ]),
      navBarHeight: Platform.isIOS ? 70.sp : 65.sp,
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.simple,
    );
  }
}
