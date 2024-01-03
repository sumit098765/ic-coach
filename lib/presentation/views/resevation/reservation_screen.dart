// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instacoach/domain/repositories/api_repositories.dart';
import 'package:instacoach/logic/cubits/filter_cubit/filter_cubit.dart';
import 'package:instacoach/logic/cubits/filter_cubit/filter_state.dart';
import 'package:instacoach/logic/cubits/notification_cubit/get_notify_count_cubit/get_notify_count_cubit.dart';
import 'package:instacoach/logic/cubits/notification_cubit/get_notify_count_cubit/get_notify_count_state.dart';
import 'package:instacoach/logic/cubits/reset_filter/reset_filter_cubit.dart';
import 'package:instacoach/presentation/views/resevation/notification_screen.dart';
import 'package:instacoach/presentation/widgets/appbar.dart';
import 'package:instacoach/presentation/widgets/text_widget.dart';
import 'package:instacoach/utils/constants/colors.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../../../logic/cubits/get_all_reservation_cubit/get_all_reservations_cubit.dart';
import '../../widgets/date_formate_method.dart';
import '../../widgets/filter_bottom_sheet_widget.dart';
import '../../widgets/presistent_navigation_widget.dart';
import 'reservation_detail_screen.dart';
import '../../widgets/gradient_button.dart';

Future<dynamic> _firebaseMessagingBackgroundHandler(
    RemoteMessage message) async {
  log("onBackground::");
  log(message.notification!.title.toString());
}

class ReservationScreen extends StatefulWidget {
  ReservationScreen({
    super.key,
    this.coachId,
  });
  String? coachId;
  String? selectedFilter;

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen>
    with WidgetsBindingObserver {
  void updateCount() async {
    final counttt = BlocProvider.of<GetNotifyCountCubit>(context);
    await counttt.loadNotifyCount(widget.coachId ?? "");
  }

  var c1 = "bbb179a0-7788-4f12-9f7f-a7df046690ce";
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  final RefreshController refreshController = RefreshController();
  final RefreshController filterRefreshController = RefreshController();
  int reservatinPage = 1;

  int pageNumber = 1;
  var reservation = [];
  var fRes = [];

  void registerNotifications() async {
    final firebasemessaging = FirebaseMessaging.instance;
    await firebasemessaging.requestPermission();
    final fcmToken = await firebasemessaging.getToken();

    final apiServices = ApiServices();

    final deviceFcmToken = await secureStorage.read(key: "fcmtoken");

    bool isTokenSame = fcmToken == deviceFcmToken ? true : false;

    if (!isTokenSame) {
      await secureStorage.write(key: "fcmtoken", value: fcmToken);
      await apiServices.updateFCMTokensRepository(
          widget.coachId as String, fcmToken as String);
    }

    //print("TOKEN:: $fcmToken");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //post api to save notification in notification table
      BlocProvider.of<GetNotifyCountCubit>(context)
          .loadNotifyCount(widget.coachId ?? "");
      log("onMessage::");
      log(message.notification!.title.toString());
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      updateCount();

      log("onMessageOpenedApp::");
      log(message.notification!.title.toString());
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      presistentNavigationWidget(
          context,
          NotificationScreen(
            CoachID: widget.coachId ?? "",
          ));
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetAllReservationCubit>(context)
        .loadPosts(widget.coachId ?? c1, reservatinPage);
    WidgetsBinding.instance.addObserver(this);
    updateCount();
    registerNotifications();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      updateCount();
    }
  }

  bool isFilterResfresh = false;

  void _onRefresh() async {
    reservatinPage = 1;
    await BlocProvider.of<GetAllReservationCubit>(context)
        .loadPosts(widget.coachId ?? c1, reservatinPage);
    log("page number $reservatinPage");
    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    reservatinPage++;
    await BlocProvider.of<GetAllReservationCubit>(context)
        .loadPosts(widget.coachId ?? c1, reservatinPage);
    refreshController.loadComplete();
  }

  void _onFilterRefresh() async {
    pageNumber = 1;
    isFilterResfresh = true;
    log("filter page numbers $pageNumber");
    log("selected filter before refresh: ${widget.selectedFilter}");
    log("current filter before refresh: $currentFilter");
    await BlocProvider.of<FilterCubit>(context).fetchAccToFilter(
        widget.coachId ?? c1, widget.selectedFilter.toString(), pageNumber);

    setState(() {
      log("selected filter after refresh: ${widget.selectedFilter}");
      log("current filter after refresh: $currentFilter");
      currentFilter = widget.selectedFilter.toString();
    });

    filterRefreshController.refreshCompleted();
  }

  void _onFilterLoading() async {
    isFilterResfresh = false;
    // pageNumber++;
    await BlocProvider.of<FilterCubit>(context).fetchAccToFilter(
        widget.coachId ?? c1, widget.selectedFilter.toString(), pageNumber);
    filterRefreshController.loadComplete();
    // pageNumber++;
  }

  Map<String, String> displayMapping = {
    "scheduled": "Upcoming",
    "completed": "Completed",
    "cancelled": "Cancelled",
  };

  bool hasScheduledReservations = false;
  String currentFilter = '';
  @override
  Widget build(BuildContext context) {
    log("Coach ID in Reservations ${widget.coachId}");
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: appbar1(
          context: context,
          title: "Reservations",
          visible: false,
          icon: InkWell(
              onTap: () {
                presistentNavigationWidget(
                    context,
                    NotificationScreen(
                      CoachID: widget.coachId ?? "",
                      pageNumber: reservatinPage,
                      filter: widget.selectedFilter,
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
                        // log("Count ${count.data.count}");
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
                                        // height: 15,
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
              )),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: widget.selectedFilter == null
                          ? displayMapping["scheduled"]!
                          : displayMapping[widget.selectedFilter!]!,
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    ),
                    InkWell(
                      onTap: () {
                        FilterBottomSheetWidget.showSheet(
                            context, widget.coachId ?? c1, (selectedValue) {
                          setState(() {
                            widget.selectedFilter = selectedValue;
                            //log("widget.selectedFilter ${widget.selectedFilter}");
                          });
                        }, 1);
                      },
                      child: SvgPicture.asset(
                        "assets/images/filter.svg",
                        height: 20,
                        width: 17,
                      ),
                    )
                  ],
                ),
              ),
            ),
            BlocListener<ResetFilterCubit, ResetFilterState>(
              listener: (context, state) {
                if (state is ResetFilterDone) {
                  log("resetting ");
                  setState(() {
                    pageNumber = 1;
                    fRes = [];
                  });
                }
              },
              child:
                  BlocConsumer<GetAllReservationCubit, GetAllReservationsState>(
                listener: (context, state) {
                  if (state is GetAllReservationLoadedState) {
                    if (reservatinPage == 1) {
                      reservation = state.reservations;
                    } else {
                      reservation += state.reservations;
                    }
                  }
                },
                builder: (context, state) {
                  if (state is GetAllReservationLoadingState) {
                    return const Expanded(
                        child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.black,
                      ),
                    ));
                  } else if (state is GetAllReservationLoadedState ||
                      state is GetAllReservatioLoadedEmptyState) {
                    if (widget.selectedFilter == null && reservation.isEmpty) {
                      return Expanded(
                          child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: SvgPicture.asset(
                              "assets/images/calendar_reservation.svg",
                              width: 180,
                              height: 180,
                            )),
                            const SizedBox(
                              height: 20,
                            ),
                            const TextWidget(
                              text: "No Reservations",
                              color: AppColors.selectedBlue,
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const TextWidget(
                              text: "You don't have any upcoming reservation",
                              fontSize: 13,
                              color: AppColors.darkGrey,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            gradientButton1(
                                context: context,
                                rWidth: 160,
                                rHeight: 35,
                                btnText: "Refresh",
                                txtColor: AppColors.white,
                                color: AppColors.selectedBlue,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                onPress: _onRefresh)
                          ],
                        ),
                      ));
                    } else {
                      return widget.selectedFilter == null &&
                              reservation.isNotEmpty
                          ? reservationWidget(context, reservation)
                          : BlocConsumer<FilterCubit, FilterState1>(
                              listener: (context, state) {
                                if (state is FilterLoadedState) {
                                  setState(() {
                                    log("selected filter ${widget.selectedFilter}");
                                    log("current filter $currentFilter");
                                    log("Is filters same .....${widget.selectedFilter == currentFilter}");
                                    pageNumber = pageNumber + 1;
                                    if (widget.selectedFilter !=
                                            currentFilter &&
                                        isFilterResfresh == false) {
                                      fRes = state.getAllReservation.data!
                                          .reservation!.rows!;

                                      currentFilter =
                                          widget.selectedFilter.toString();
                                    } else if (widget.selectedFilter ==
                                            currentFilter &&
                                        reservatinPage == 1 &&
                                        isFilterResfresh == true) {
                                      fRes = state.getAllReservation.data!
                                          .reservation!.rows!;
                                    } else {
                                      fRes += state.getAllReservation.data!
                                          .reservation!.rows!;
                                    }
                                    log("count${state.getAllReservation.data!.reservation!.count}");
                                  });
                                }
                              },
                              builder: (context, state) {
                                if (state is FilterLodaingState) {
                                  return const Expanded(
                                      child: Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.black,
                                    ),
                                  ));
                                } else if (state is FilterLoadedState) {
                                  return reservationWidget(context, fRes);
                                } else if (state is FilterEmptyState) {
                                  return Expanded(
                                      child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                            child: SvgPicture.asset(
                                          "assets/images/calendar_reservation.svg",
                                          width: 180,
                                          height: 180,
                                        )),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const TextWidget(
                                          text: "No Reservations",
                                          color: AppColors.selectedBlue,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 22,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextWidget(
                                          text:
                                              "You don't have any ${widget.selectedFilter == 'scheduled' ? 'upcoming' : widget.selectedFilter} reservation",
                                          fontSize: 13,
                                          color: AppColors.darkGrey,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        gradientButton1(
                                            context: context,
                                            rWidth: 160,
                                            rHeight: 35,
                                            btnText: "Refresh",
                                            txtColor: AppColors.white,
                                            color: AppColors.selectedBlue,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            onPress: _onFilterRefresh)
                                      ],
                                    ),
                                  ));
                                } else {
                                  return const Center(
                                    child: Text("Something went wrong"),
                                  );
                                }
                              },
                            );
                    }
                  } else if (state is ErrorState) {
                    return Expanded(
                        child: Center(
                      child: TextWidget(
                        text: state.message,
                        color: AppColors.black,
                      ),
                    ));
                  } else {
                    return const Text("something went wrong");
                  }
                },
              ),
            ),
          ],
        ));
  }

  reservationWidget(BuildContext context, List fRes) {
    return Expanded(
        child: SizedBox(
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.sp,
                ),
                child: SmartRefresher(
                  controller: widget.selectedFilter != null
                      ? filterRefreshController
                      : refreshController,
                  enablePullDown: true,
                  enablePullUp: true,
                  onRefresh: widget.selectedFilter != null
                      ? _onFilterRefresh
                      : _onRefresh,
                  onLoading: widget.selectedFilter != null
                      ? _onFilterLoading
                      : _onLoading,
                  header: const ClassicHeader(),
                  footer: CustomFooter(
                    height: 45,
                    builder: (BuildContext context, LoadStatus? mode) {
                      Widget body;
                      if (mode == LoadStatus.idle) {
                        body = const Center(
                            child: Center(
                          child: Text("Pull up to load more data", style: TextStyle(color: AppColors.darkGrey)),
                        ));
                        return body;
                      } else if (mode == LoadStatus.noMore) {
                        body = const Center(child: Text("No more data"));
                        return body;
                      } else if (mode == LoadStatus.loading) {
                        body = const Center(
                          child: SizedBox(
                            width: 40,
                            child: CircularProgressIndicator(
                              color: AppColors.black,
                            ),
                          ),
                        );
                        return body;
                      } else if (mode == LoadStatus.failed) {
                        body = const Center(
                          child: Text("Load failed! Click retry!"),
                        );
                        return body;
                      } else if (mode == LoadStatus.canLoading) {
                        body = const Center(
                          child: Text("Release to load more", style: TextStyle(color: AppColors.darkGrey)),
                        );
                        return body;
                      } else {
                        body = const Center(
                          child: Text("No more data"),
                        );
                        return body;
                      }
                    },
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: fRes.length,
                    itemBuilder: (context, index) {
                      // log("fres from filter ${fRes}");
                      DateTimeInfo dateTimeInfo = formatDate(index, fRes);

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReservationDetailScreen(
                                  reservationId: fRes[index]
                                      .reservation!
                                      .reservationId
                                      .toString(),
                                  purchaseType: fRes[index]
                                      .reservation!
                                      .purchaseType
                                      .toString(),
                                  index: index,
                                  CoachId: widget.coachId ?? "",
                                ),
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6.sp),
                          margin: EdgeInsets.symmetric(
                              vertical: 9.sp, horizontal: 3),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(16),
                              border:
                                  Border.all(color: const Color(0xFFDBE7FF))),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/images/pH.svg",
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                  width: 200.sp,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 13.sp),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Text(fRes[index].reservation.status),
                                        TextWidget(
                                          text:
                                              fRes[index].user!.name.toString(),
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.selectedBlue,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        TextWidget(
                                          text: fRes[index]
                                              .reservation!
                                              .location
                                              .toString(),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.subBlack,
                                        ),
                                        SizedBox(
                                          height: 5.sp,
                                        ),
                                        Container(
                                          height: 19.sp,
                                          width: 90.sp,
                                          decoration: BoxDecoration(
                                              color: fRes[index]
                                                          .reservation!
                                                          .type ==
                                                      "In-Person"
                                                  ? AppColors.pink
                                                  : fRes[index]
                                                              .reservation!
                                                              .type ==
                                                          "Virtual"
                                                      ? AppColors.lightyellow
                                                      : AppColors.lightBlue,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Center(
                                            child: TextWidget(
                                              text: fRes[index]
                                                  .reservation!
                                                  .type
                                                  .toString(),
                                              fontSize: 11.sp,
                                              fontFamily: "R.font.roboto",
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5.sp),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 100.sp,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.calendar_today,
                                                    size: 14.sp,
                                                    color:
                                                        AppColors.textLightGrey,
                                                  ),
                                                  SizedBox(
                                                    width: 2.sp,
                                                  ),
                                                  Flexible(
                                                    flex: 1,
                                                    fit: FlexFit.loose,
                                                    child: TextWidget(
                                                      text: dateTimeInfo
                                                          .formattedDate
                                                          .toString(),
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .textLightGrey,
                                                      textOverflow:
                                                          TextOverflow.visible,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.sp,
                                            ),
                                            SizedBox(
                                              width: 78.sp,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    CupertinoIcons.clock,
                                                    size: 14.sp,
                                                    color:
                                                        AppColors.textLightGrey,
                                                  ),
                                                  SizedBox(
                                                    width: 2.sp,
                                                  ),
                                                  Flexible(
                                                    fit: FlexFit.tight,
                                                    flex: 1,
                                                    child: TextWidget(
                                                      text: dateTimeInfo
                                                          .formattedTime
                                                          .toString(),
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .textLightGrey,
                                                      textOverflow:
                                                          TextOverflow.visible,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              const Icon(
                                Icons.chevron_right,
                                size: 28,
                                color: AppColors.black,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ))));
  }
}
