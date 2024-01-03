// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instacoach/logic/cubits/unavailibility_cubit/delete_unavailibility_cubit/delete_unavailibility_cubit.dart';
import 'package:instacoach/logic/cubits/unavailibility_cubit/get_unavailibility_cubit/get_unavailibility_cubit.dart';
import 'package:instacoach/logic/cubits/unavailibility_cubit/get_unavailibility_cubit/get_unavailibility_state.dart';
import 'package:instacoach/presentation/widgets/text_widget.dart';
import 'package:instacoach/utils/constants/colors.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../logic/blocs/availibility_and_unavailibility_bloc/create_unavailibility_bloc/bloc/create_unavailibility_bloc.dart';
import '../../../logic/blocs/availibility_and_unavailibility_bloc/create_unavailibility_bloc/bloc/create_unavailibility_state.dart';
import '../../../logic/cubits/unavailibility_cubit/delete_unavailibility_cubit/delete_unavailibility_state.dart';
import '../../widgets/availibility_bottom_sheet.dart';
import 'package:intl/intl.dart';

class UnavailibilityScreen extends StatefulWidget {
  const UnavailibilityScreen({super.key, this.coachId});
  final String? coachId;

  @override
  State<UnavailibilityScreen> createState() => _UnavailibilityScreenState();
}

class _UnavailibilityScreenState extends State<UnavailibilityScreen> {
  List existingRange = [];
  String formatTimeRange(int startTime, int endTime) {
    final startHour = startTime ~/ 100;
    final startMinute = startTime % 100;
    final endHour = endTime ~/ 100;
    final endMinute = endTime % 100;

    final formattedStartTime =
        TimeOfDay(hour: startHour, minute: startMinute).format(context);
    final formattedEndTime =
        TimeOfDay(hour: endHour, minute: endMinute).format(context);

    return '$formattedStartTime - $formattedEndTime';
  }

  DateTime? today = DateTime.now();
  var wordFormattedDate;
  late String formattedDate;
  var initailTime;
  var timeRange;
  var idsToDelete;

  var isBlockedWholeDay;
  var date;
  @override
  void initState() {
    initailTime = DateFormat('yyyy-MM-dd').format(today!);
    wordFormattedDate = DateFormat('MMM-dd-yyyy').format(today!);
    formattedDate = initailTime;
    BlocProvider.of<GetUnavailibilityCubit>(context)
        .loadOverrides(false, widget.coachId ?? "", formattedDate);

    super.initState();
  }

  void onDaySelected(DateTime day, DateTime focusedDat) {
    formattedDate = DateFormat('yyyy-MM-dd').format(day);
    wordFormattedDate =
        wordFormattedDate = DateFormat('MMM-dd-yyyy').format(day);
    log(" _onDaySelected === $formattedDate");
    setState(() {
      today = day;
    });

    BlocProvider.of<GetUnavailibilityCubit>(context)
        .loadOverrides(true, widget.coachId ?? "", formattedDate);
  }

  void openBottomSheet(String selectedDate) {
  
  
    DatePickerBottomSheetWidget.showModal(
      context,
      true,
      [],
      widget.coachId ?? "",
      existingTimeRanges: existingRange,
      selectedDate: selectedDate,
      idsToDelete: idsToDelete,
      date: date,
      isBlockforWholeDay: isBlockedWholeDay ?? false,
    );
  }

  final msg = BlocBuilder<CreateUnavailibilityBloc, CreateUnavailibilityState>(
      builder: (context, state) {
    if (state is CreateUnavailibilityLoadingState) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.black,
        ),
      );
    } else {
      return Container();
    }
  });
  @override
  Widget build(BuildContext context) {
    // log("formated date ${formattedDate}");
    return Scaffold(
      body: BlocListener<DeleteUnAvailibilityCubit, DeleteUnAvailibilityState>(
        listener: (context, state) {
          if (state is DeleteUnAvailibilityLoadedState) {
            Fluttertoast.showToast(msg: "Deleted successfully");
          } else if (state is DeleteUnAvailibilityUnBlockLoadedState) {
            Fluttertoast.showToast(msg: "Unblocked successfully");
          }
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TableCalendar(
                      availableGestures: AvailableGestures.horizontalSwipe,
                      rowHeight: 50.sp,
                      selectedDayPredicate: (day) => isSameDay(day, today),
                      headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          leftChevronMargin: EdgeInsets.only(left: 50.sp),
                          rightChevronMargin: EdgeInsets.only(right: 50.sp)),
                      focusedDay: today!,
                      firstDay: DateTime.now(),
                      lastDay: DateTime.utc(2025),
                      onPageChanged: (focusedDay) {
                        today = focusedDay;
                        formattedDate =
                            DateFormat('yyyy-MM-dd').format(focusedDay);
                        setState(() {
                          wordFormattedDate = wordFormattedDate =
                              DateFormat('MMM-dd-yyyy').format(focusedDay);
                        });

                        BlocProvider.of<GetUnavailibilityCubit>(context)
                            .loadOverrides(
                                false, widget.coachId ?? "", formattedDate);
                      },
                      onDaySelected: onDaySelected,
                      calendarStyle: const CalendarStyle(
                          isTodayHighlighted: false,
                          selectedDecoration: BoxDecoration(
                              color: AppColors.black, shape: BoxShape.circle)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      thickness: 1,
                      color: AppColors.lightBlue,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/earth.png"),
                        const SizedBox(
                          width: 10,
                        ),
                        const TextWidget(
                          text: "Pacific Time - US & Canada (2:49pm)",
                          color: AppColors.selectedBlue,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      thickness: 1,
                      color: AppColors.lightBlue,
                    ),
                    const SizedBox(height: 6),
                    const TextWidget(
                      text: "Select a date to set availability",
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Divider(
                      thickness: 1,
                      color: AppColors.lightBlue,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 14),
                          child: TextWidget(
                            text: wordFormattedDate.toString(),
                            fontSize: 14,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocConsumer<GetUnavailibilityCubit,
                                GetUnavailibilityState>(
                              listener: (context, state) {
                                if (state is GetUnavailibilityLoadedState) {
                                  final overrideDates = state.getOverrides;
                                  isBlockedWholeDay =
                                      overrideDates.data!.isFullDayBlocked;
                                  final allotEntry = overrideDates
                                      .data!.allots.allotMap.entries
                                      .map((e) => e.value)
                                      .toList();
                                  existingRange = allotEntry;
                                  if (overrideDates.data!.isFullDayBlocked ==
                                      true) {
                                    var ids = overrideDates
                                        .data!.blocks.blockMap.keys;
                                    if (ids.isNotEmpty) {
                                      idsToDelete = int.parse(ids.first);
                                    }
                                  }

                                  if (state.showBottomSheet) {
                                    openBottomSheet(formattedDate);
                                  }
                                }
                              },
                              builder: (context, state) {
                                if (state is GetUnavailibilityLoadingState) {
                                  return const TextWidget(
                                    text: "\nLoading.....",
                                  );
                                } else if (state
                                    is GetUnavailibilityLoadedState) {
                                  final overrideDates = state.getOverrides;
                                  final allotEntry = overrideDates
                                      .data!.allots.allotMap.entries
                                      .map((e) => e.value)
                                      .toList();

                                  existingRange = allotEntry;

                                  if (overrideDates.data!.isFullDayBlocked ==
                                      true) {
                                    var ids = overrideDates
                                        .data!.blocks.blockMap.keys;
                                    if (ids.isNotEmpty) {
                                      idsToDelete = int.parse(ids.first);
                                    }
                                  }

                                  date = overrideDates.data!.date;
                                  log("date inside listView $date");
                                  return existingRange.isEmpty &&
                                          formattedDate == date
                                      ? Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          height: 42,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              boxShadow: const [
                                                BoxShadow(
                                                    blurRadius: 1,
                                                    spreadRadius: 1,
                                                    color: AppColors.lightBlue)
                                              ]),
                                          child: Center(
                                              child: TextWidget(
                                                  text: overrideDates
                                                              .data!
                                                              .blocks
                                                              .blockMap
                                                              .values
                                                              .isEmpty &&
                                                          overrideDates.data!
                                                                  .isFullDayBlocked ==
                                                              false &&
                                                          overrideDates.data!
                                                              .date.isNotEmpty
                                                      ? "No override date"
                                                      : "Unavailable")),
                                        )
                                      : SizedBox(
                                          width: 176,
                                         
                                          child: ListView.builder(
                                              physics: const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: overrideDates
                                                  .data!
                                                  .allots
                                                  .allotMap
                                                  .entries
                                                  .length,
                                              itemBuilder: (context, index) {
                                                final allotEntry = overrideDates
                                                    .data!
                                                    .allots
                                                    .allotMap
                                                    .entries
                                                    .elementAt(index);

                                                final idToDelete = overrideDates
                                                    .data!
                                                    .allots
                                                    .allotMap
                                                    .entries
                                                    .elementAt(index)
                                                    .key;

                                                timeRange = formatTimeRange(
                                                  allotEntry.value[0],
                                                  allotEntry.value[1],
                                                );

                                                return Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        BlocProvider.of<
                                                                    DeleteUnAvailibilityCubit>(
                                                                context)
                                                            .deleteUnAvailibilities(
                                                                widget.coachId ??
                                                                    "",
                                                                formattedDate,
                                                                int.parse(
                                                                    idToDelete),
                                                                context,
                                                                false,
                                                                BlocProvider.of<
                                                                        GetUnavailibilityCubit>(
                                                                    context));

                                                        // await Future.delayed(
                                                        //     const Duration(
                                                        //         seconds: 2));

                                                        // BlocProvider.of<
                                                        //             GetUnavailibilityCubit>(
                                                        //         context)
                                                        //     .loadOverrides(
                                                        //         false,
                                                        //         widget.coachId ??
                                                        //             "",
                                                        //         formattedDate);
                                                      },
                                                      child: Image.asset(
                                                        "assets/images/g1.png",
                                                        height: 24,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      height: 42,
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              AppColors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                                blurRadius: 1,
                                                                spreadRadius: 1,
                                                                color: AppColors
                                                                    .lightGrey)
                                                          ]),
                                                      child: Center(
                                                          child: TextWidget(
                                                              text: timeRange)),
                                                    ),
                                                  ],
                                                );
                                              }),
                                        );
                                } else if (state
                                    is GetUnavailibilityErrorState) {
                                  return const Center(
                                    child: TextWidget(
                                        text: "Something went wrong"),
                                  );
                                }

                                return const TextWidget(text: "Empty");
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: InkWell(
                                onTap: () {
                                  openBottomSheet(formattedDate);
                                },
                                child: const Icon(
                                  Icons.add,
                                  size: 24,
                                  color: AppColors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            msg
          ],
        ),
      ),
      //  bottomNavigationBar:
    );
  }
}
