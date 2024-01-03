import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

void presistentNavigationWidget(BuildContext context, Widget widget) {
  PersistentNavBarNavigator.pushNewScreen(
    context,
    screen: widget,
    withNavBar: false, 
    pageTransitionAnimation: PageTransitionAnimation.cupertino,
  );
}
