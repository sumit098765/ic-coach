// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instacoach/logic/cubits/get_all_reservation_cubit/get_all_reservations_cubit.dart';
import 'package:instacoach/logic/cubits/notification_cubit/get_notify_count_cubit/get_notify_count_cubit.dart';
import 'package:instacoach/logic/cubits/notification_cubit/get_notify_cubit/get_notify_cubit.dart';
import 'package:instacoach/logic/cubits/notification_cubit/get_notify_cubit/get_notify_state.dart';
import 'package:instacoach/utils/constants/colors.dart';
import '../../../logic/cubits/filter_cubit/filter_cubit.dart';
import '../../widgets/text_widget.dart';

String timeAgo(DateTime d) {
  Duration diff = DateTime.now().difference(d);
  if (diff.inDays > 365) {
    return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
  }
  if (diff.inDays > 30) {
    return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
  }
  if (diff.inDays > 7) {
    return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  }
  if (diff.inDays > 0) {
    return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
  }
  if (diff.inHours > 0) {
    return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
  }
  if (diff.inMinutes > 0) {
    return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
  }
  return "just now";
}

class NotificationScreen extends StatefulWidget {
  NotificationScreen(
      {super.key, required this.CoachID, this.pageNumber, this.filter});
  final String CoachID;
  final int? pageNumber;
  var filter;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    BlocProvider.of<GetNotifyCubit>(context).loadNotify(widget.CoachID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const TextWidget(
              text: "Notifications",
              color: AppColors.black,
              fontWeight: FontWeight.w600,
              fontSize: 21,
            ),
            leading: InkWell(
              onTap: () {
                if (widget.filter == null) {
                  BlocProvider.of<GetAllReservationCubit>(context)
                      .loadPosts(widget.CoachID, widget.pageNumber ?? 1);
                } else {
                  BlocProvider.of<FilterCubit>(context)
                      .fetchAccToFilter(widget.CoachID, widget.filter, 1);
                }
                Navigator.pop(context);
                BlocProvider.of<GetNotifyCountCubit>(context)
                    .loadNotifyCount(widget.CoachID);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.black,
                size: 20,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4.0),
              child: Container(
                color: const Color(0xFFDBE7FF),
                height: 1.0,
              ),
            )),
        body: BlocBuilder<GetNotifyCubit, GetNotifyState>(
          builder: (context, state) {
            if (state is GetNotifyLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.black,
                ),
              );
            } else if (state is GetNotifyLoadedState) {
              final notifys = state.getNotify;
              return Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 20, top: 10, bottom: 10),
                child: ListView.builder(
                  itemCount: notifys.data.notifications.length,
                  itemBuilder: (context, index) {
                    DateTime dateTime = DateTime.parse(
                        notifys.data.notifications[index].createdAt);

                    String timeAgoString = timeAgo(dateTime);

                    String sentTime = timeAgoString;
                    return Container(
                      padding: const EdgeInsets.only(
                        bottom: 0,
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      //width: 320,
                      child: Column(
                        children: [
                          ListTile(
                            leading: notifys.data.notifications[index].status ==
                                    "unseen"
                                ? const Icon(
                                    Icons.circle,
                                    size: 12,
                                    color: AppColors.selectedBlue,
                                  )
                                : const SizedBox(),
                            minLeadingWidth: 10,
                            title: TextWidget(
                              text: notifys.data.notifications[index].title,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.black,
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: TextWidget(
                                text: notifys.data.notifications[index].body,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: AppColors.subBlack,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: TextWidget(
                                text: sentTime,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: AppColors.subBlack,
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Divider(
                              thickness: 1,
                              color: Color(0xFFDBE7FF),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            } else if (state is GetNotifyEmptyState) {
              return const Center(
                child: TextWidget(text: "No notification yet!"),
              );
            } else {
              return const TextWidget(text: "Error");
            }
          },
          // listener: (context, state) {},
        ));
  }
}
