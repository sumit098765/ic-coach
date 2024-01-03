import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instacoach/presentation/views/availibility&unavailibility/availibility_screen.dart';
import 'package:instacoach/presentation/views/availibility&unavailibility/unavailibility_screen.dart';
import 'package:instacoach/presentation/views/resevation/notification_screen.dart';
import 'package:instacoach/presentation/widgets/appbar.dart';
import 'package:instacoach/presentation/widgets/presistent_navigation_widget.dart';
import 'package:instacoach/presentation/widgets/text_widget.dart';
import 'package:instacoach/utils/constants/colors.dart';

import '../../../logic/cubits/notification_cubit/get_notify_count_cubit/get_notify_count_cubit.dart';
import '../../../logic/cubits/notification_cubit/get_notify_count_cubit/get_notify_count_state.dart';

class AvaiAndUnAvaiScreen extends StatelessWidget {
  const AvaiAndUnAvaiScreen({super.key, this.coachId});
  final String? coachId;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: appbar1(
          context: context,
          title: "Available Hours",
          visible: false,
          icon: InkWell(
              onTap: () {
                presistentNavigationWidget(
                    context,
                    NotificationScreen(
                      CoachID: coachId ?? "",
                    ));
              },
              child: Stack(
                children: [
                  SvgPicture.asset("assets/images/notify.svg", height: 24),
                  BlocBuilder<GetNotifyCountCubit, GetNotifyCountState>(
                    builder: (context, state) {
                      if (state is GetNotifyCountLoadingState) {
                        return const Center();
                      } else if (state is GetNotifyCountLoadedState) {
                        final count = state.notifyCount;

                        return count.data.count == '0'
                            ? const SizedBox()
                            : Positioned(
                                left: 9,
                                child: SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: Stack(
                                    children: [
                                      Image.asset(
                                        "assets/images/badge.png",
                                        color: AppColors.red,
                                      ),
                                      Center(
                                        child: TextWidget(
                                          text: count.data.count.toString(),
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                      }
                      return const TextWidget(text: "X");
                    },
                  )
                ],
              )
              //  SvgPicture.asset(
              //   "assets/images/notify.svg",
              // ),
              ),
          preferredSize: TabBar(
            indicatorColor: AppColors.selectedBlue,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: AppColors.grey3,
            labelColor: AppColors.black,
            labelPadding: const EdgeInsets.only(bottom: 5),
            padding: EdgeInsets.only(right: 145.sp, left: 5, bottom: 5),
            enableFeedback: false,
            splashFactory: NoSplash.splashFactory,
            tabs: [
              TextWidget(
                text: "Weekly hours",
                //color: App,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),

              TextWidget(
                text: "Date overrides",
                // color: AppColors.black,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
              // SizedBox(),
              // SizedBox(),
            ],
          ),
        ),
        body: TabBarView(children: [
          AvailibilityScreen(
            coachId: coachId,
          ),
          UnavailibilityScreen(
            coachId: coachId,
          ),
        ]),
      ),
    );
  }
}
