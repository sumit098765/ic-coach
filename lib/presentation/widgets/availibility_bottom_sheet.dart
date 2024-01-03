// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instacoach/logic/blocs/availibility_and_unavailibility_bloc/create_availibility_bloc/bloc/create_availibility_bloc.dart';
import 'package:instacoach/logic/blocs/availibility_and_unavailibility_bloc/create_unavailibility_bloc/bloc/create_unavailibility_bloc.dart';
import 'package:instacoach/logic/blocs/availibility_and_unavailibility_bloc/create_unavailibility_bloc/bloc/create_unavailibility_event.dart';
import 'package:instacoach/logic/cubits/unavailibility_cubit/delete_unavailibility_cubit/delete_unavailibility_cubit.dart';
import 'package:instacoach/logic/cubits/unavailibility_cubit/get_unavailibility_cubit/get_unavailibility_cubit.dart';
import 'package:instacoach/presentation/widgets/switch_widget.dart';
import '../../logic/blocs/availibility_and_unavailibility_bloc/create_unavailibility_bloc/bloc/create_unavailibility_state.dart';
import '../../logic/cubits/avaibility_cubit/get_availibility_cubit/get_availibility_cubit.dart';
import '../../utils/constants/colors.dart';
import 'text_widget.dart';
import 'package:intl/intl.dart';

class DatePickerBottomSheetWidget {
  static Map<String, String> dayAbbreviations = {
    "Sundays": "Sun",
    "Mondays": "Mon",
    "Tuesdays": "Tue",
    "Wednesdays": "Wed",
    "Thursdays": "Thu",
    "Fridays": "Fri",
    "Saturdays": "Sat",
  };
  static bool isBlocked = false;

  static void showModal(
    BuildContext context,
    bool visibility,
    List<String> enableDays,
    String coachId, {
    List existingTimeRanges = const [],
    var selectedDate = "",
    var idsToDelete,
    var date,
    bool isBlockforWholeDay = false,
  }) {
    TimeOfDay selectedStartTime =
        TimeOfDay.fromDateTime(DateTime.parse("20120227 08:00:00"));
    TimeOfDay selectedEndTime =
        TimeOfDay.fromDateTime(DateTime.parse("20120227 17:00:00"));
    bool isLoading = false;
    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            // log("selected date $selectedDate");
            // log("Date $date");
            // log("isBlockforWholeDay $isBlockforWholeDay");
            // log("existing range $existingTimeRanges");
            return BlocListener<CreateAvailibilityBloc,
                CreateAvailibilityState>(
              listener: (context, state) {
                if (state is CreateAvailibilityCreatedState) {
                  Fluttertoast.showToast(msg: "Allocated");
                } else if (state is CreateAvailibilityLoadingState) {
                  // Overlay.of(context).insert(_overlayEntry);
                } else if (state is CreateAvailibilityErrorState) {
                  Fluttertoast.showToast(msg: state.message);
                } else {
                  //_overlayEntry.remove();
                }
              },
              child: BlocListener<CreateUnavailibilityBloc,
                  CreateUnavailibilityState>(
                listener: (context, state) {
                  if (state is CreateUnavailibilityForWholeDayLoadedState) {
                    Fluttertoast.showToast(
                        msg: "You are now unavailable for whole day");
                  } else if (state is CreateUnavailibilityErrorState) {
                    Fluttertoast.showToast(msg: "Something went wrong");
                  }
                },
                child: DefaultTabController(
                    length: 2,
                    child: Container(
                      color: Colors.white,
                      child: SizedBox(
                        height: visibility == true ? 425 : 385,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: visibility == true ? 10 : 0,
                                  horizontal: 20),
                              child: visibility == true
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const TextWidget(
                                          text: "Mark as unavailable this day",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        SwitchWidget(
                                          switchText: "",
                                          switchColor: AppColors.selectedBlue,
                                          onChanged:
                                              // date == selectedDate
                                              //     ?
                                              (value) async {
                                            setState(
                                              () {
                                                isBlocked = value;
                                              },
                                            );
                                            if (value) {
                                              BlocProvider.of<
                                                          CreateUnavailibilityBloc>(
                                                      context)
                                                  .add(CreateUnavailibilityLoadedEvent(
                                                      coachId,
                                                      selectedDate,
                                                      0,
                                                      2400,
                                                      context,
                                                      BlocProvider.of<
                                                              GetUnavailibilityCubit>(
                                                          context),
                                                      isBlocked,
                                                      showBottomSheet: false));
                                              await Future.delayed(
                                                  const Duration(seconds: 0));
                                              Navigator.pop(context);
                                            } else if (!value) {
                                              BlocProvider.of<
                                                          DeleteUnAvailibilityCubit>(
                                                      context)
                                                  .deleteUnAvailibilities(
                                                      coachId,
                                                      selectedDate,
                                                      idsToDelete,
                                                      context,
                                                      true,
                                                      BlocProvider.of<
                                                              GetUnavailibilityCubit>(
                                                          context));

                                              // await Future.delayed(
                                              //     const Duration(seconds: 2));
                                              //  Navigator.pop(context);
                                              // BlocProvider.of<
                                              //             GetUnavailibilityCubit>(
                                              //         context)
                                              //     .loadOverrides(
                                              //   false,
                                              //   coachId,
                                              //   selectedDate,
                                              // );

                                              setState(
                                                () {
                                                  isBlockforWholeDay =
                                                      isBlocked;

                                                  log("message  ${selectedDate == date}");
                                                  log("isBlockforWholeDay $isBlockforWholeDay");
                                                },
                                              );
                                            }
                                          },
                                          // : null,
                                          initialStatus: isBlockforWholeDay,
                                          isVisible: true,
                                        )
                                      ],
                                    )
                                  : const SizedBox(),
                            ),
                            const SizedBox(
                              height: 0,
                            ),
                            Container(
                              color: AppColors.tabGrey,
                              child: SizedBox(
                                height: 60,
                                child: TabBar.secondary(
                                    indicator: const BoxDecoration(
                                        color: AppColors.white),
                                    tabs: [
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                            style: TextStyle(
                                              color: isBlockforWholeDay
                                                  ? AppColors.grey3
                                                  : AppColors.black,
                                            ),
                                            children: [
                                              const TextSpan(
                                                  text: 'Start Time\n'),
                                              const WidgetSpan(
                                                child: SizedBox(height: 18),
                                              ),
                                              TextSpan(
                                                  text: selectedStartTime
                                                      .format(context)
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15)),
                                            ]),
                                      ),
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          style: TextStyle(
                                            color: isBlockforWholeDay
                                                ? AppColors.grey3
                                                : AppColors.black,
                                          ),
                                          children: [
                                            const TextSpan(text: 'End Time\n'),
                                            const WidgetSpan(
                                              child: SizedBox(height: 18),
                                            ),
                                            TextSpan(
                                                text: selectedEndTime
                                                    .format(context)
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15)),
                                          ],
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                            SizedBox(
                              width: 400,
                              height: visibility == true ? 180 : 190,
                              child: TabBarView(children: [
                                MyTimePicker(
                                  selectedTime: selectedStartTime,
                                  onTimeChanged: isBlockforWholeDay
                                      ? (p) {}
                                      : (newTime) {
                                          setState(() {
                                            selectedStartTime = newTime;
                                          });
                                        },
                                  isBlock: isBlockforWholeDay,
                                ),
                                MyTimePicker(
                                  selectedTime: selectedEndTime,
                                  onTimeChanged: isBlockforWholeDay
                                      ? (p) {}
                                      : (newTime) {
                                          setState(() {
                                            selectedEndTime = newTime;
                                          });
                                        },
                                  isBlock: isBlockforWholeDay,
                                ),
                              ]),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ElevatedButton(
                              onPressed: isLoading == true
                                  ? () {}
                                  : isBlockforWholeDay
                                      ? () {}
                                      : () async {
                                          List<String> enableDayAbbreviations =
                                              enableDays
                                                  .map((day) =>
                                                      dayAbbreviations[day] ??
                                                      day)
                                                  .toList();
                                          String enableDaysString =
                                              enableDayAbbreviations.join(',');

                                          String startTime =
                                              '${selectedStartTime.hour.toString()}${selectedStartTime.minute.toString().padLeft(2, '0')}';
                                          String endTime =
                                              '${selectedEndTime.hour.toString()}${selectedEndTime.minute.toString().padLeft(2, '0')}';

                                          List selectedRange = [
                                            startTime,
                                            endTime
                                          ];
                                          // log("Existing range  $existingTimeRanges");
                                          // log("Seleted range $selectedRange");

                                          String currentDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(DateTime.now());

                                          bool isDuplicate = false;
                                          bool isOverrideDuplicate = false;

                                          bool isFirstGreater = false;
                                          bool isFirstGreaterOverride = false;
                                          if (visibility == false) {
                                            if (int.parse(startTime) >=
                                                    int.parse(endTime) ||
                                                int.parse(startTime) >=
                                                    int.parse(endTime)) {
                                              isFirstGreater = true;
                                            }
                                            for (List existingRange
                                                in existingTimeRanges) {
                                              log("inside for loop existingTimeRanges $existingTimeRanges visibility:::::::::: $visibility");
                                              if (existingRange[0] ==
                                                          int.parse(
                                                              selectedRange[
                                                                  0]) &&
                                                      existingRange[1] ==
                                                          int.parse(
                                                              selectedRange[
                                                                  1]) ||
                                                  (int.parse(selectedRange[0]) >=
                                                          existingRange[0] &&
                                                      int.parse(selectedRange[
                                                              0]) <=
                                                          existingRange[1]) ||
                                                  (int.parse(selectedRange[
                                                              1]) >=
                                                          existingRange[0] &&
                                                      int.parse(selectedRange[
                                                              1]) <=
                                                          existingRange[1])) {
                                                isDuplicate = true;
                                                break;
                                              }
                                            }
                                          } else {
                                            if (int.parse(startTime) >=
                                                    int.parse(endTime) ||
                                                int.parse(startTime) ==
                                                    int.parse(endTime)) {
                                              isFirstGreaterOverride = true;
                                            }
                                            for (List range
                                                in existingTimeRanges) {
                                              int startExisting = range[0];
                                              int endExisting = range[1];
                                              int startSelected =
                                                  int.parse(selectedRange[0]);
                                              int endSelected =
                                                  int.parse(selectedRange[1]);

                                              bool isStartWithinExisting =
                                                  startSelected >=
                                                          startExisting &&
                                                      startSelected <
                                                          endExisting;
                                              bool isEndWithinExisting =
                                                  endSelected > startExisting &&
                                                      endSelected <=
                                                          endExisting;
                                              bool isExistingWithinSelected =
                                                  startExisting >=
                                                          startSelected &&
                                                      endExisting <=
                                                          endSelected;

                                              if (isStartWithinExisting ||
                                                  isEndWithinExisting ||
                                                  isExistingWithinSelected) {
                                                isOverrideDuplicate = true;
                                                break;
                                              }
                                            }
                                          }

                                          if (isDuplicate &&
                                                  enableDaysString.isNotEmpty ||
                                              isOverrideDuplicate &&
                                                  selectedDate.isNotEmpty) {
                                            log("isOverrideDuplicate $isOverrideDuplicate");
                                            Fluttertoast.showToast(
                                                toastLength: Toast.LENGTH_LONG,
                                                msg:
                                                    "You can't use duplicate Time \n choose diffrent time");
                                          } else if (isFirstGreater &&
                                                  enableDaysString.isNotEmpty ||
                                              isFirstGreaterOverride &&
                                                  selectedDate.isNotEmpty) {
                                            Fluttertoast.showToast(
                                                toastLength: Toast.LENGTH_LONG,
                                                msg:
                                                    "start time can't be greater than end time and neither equal");
                                          } else if (visibility == false) {
                                            setState(
                                              () {
                                                isLoading = true;
                                              },
                                            );
                                            BlocProvider.of<
                                                        CreateAvailibilityBloc>(
                                                    context)
                                                .add(
                                                    CreateAvailibilityCreatedEvent(
                                              coachId,
                                              currentDate.toString(),
                                              enableDaysString,
                                              startTime.toString(),
                                              endTime.toString(),
                                              BlocProvider.of<
                                                      GetAvailibilityCubit>(
                                                  context),
                                            ));
                                            await Future.delayed(
                                                const Duration(seconds: 0));
                                            Navigator.pop(context);
                                            // BlocProvider.of<
                                            //             GetAvailibilityCubit>(
                                            //         context)
                                            //     .loadavailibilities(coachId);
                                            setState(
                                              () {
                                                isLoading = false;
                                              },
                                            );
                                          } else {
                                            setState(
                                              () {
                                                isLoading = true;
                                              },
                                            );
                                            BlocProvider.of<
                                                        CreateUnavailibilityBloc>(
                                                    context)
                                                .add(CreateUnavailibilityLoadedEvent(
                                                    coachId,
                                                    selectedDate,
                                                    int.parse(startTime),
                                                    int.parse(endTime),
                                                    context,
                                                    BlocProvider.of<
                                                            GetUnavailibilityCubit>(
                                                        context),
                                                    false,
                                                    showBottomSheet: false));
                                            await Future.delayed(
                                                const Duration(seconds: 0));
                                            Navigator.pop(context);
                                            setState(
                                              () {
                                                isLoading = true;
                                              },
                                            );
                                          }
                                        },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: isBlockforWholeDay
                                    ? AppColors.grey3
                                    : AppColors.black,
                                fixedSize: Size(330.sp, 44),
                              ),
                              child: isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.white,
                                      ),
                                    )
                                  : TextWidget(
                                      text: isBlockforWholeDay
                                          ? "Set as unavailable"
                                          : "Use these times",
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 330.sp,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  height: 44,
                                  child: const TextWidget(
                                    text: "Cancel",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    )),
              ),
            );
            // msg,
          },
        );
      },
    );
  }
}

class MyTimePicker extends StatefulWidget {
  final TimeOfDay selectedTime;
  final Function(TimeOfDay) onTimeChanged;
  final bool isBlock;

  const MyTimePicker(
      {super.key,
      required this.selectedTime,
      required this.onTimeChanged,
      required this.isBlock});
  @override
  MyTimePickerState createState() => MyTimePickerState();
}

class MyTimePickerState extends State<MyTimePicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 200,
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child:
                    //isSwitchEnabled == selectedDate &&
                    widget.isBlock
                        ? Image.asset(
                            "assets/images/TimePicker.png",
                            color: AppColors.grey3,
                          )
                        : CupertinoDatePicker(
                            // backgroundColor: AppColors.black,
                            mode: CupertinoDatePickerMode.time,
                            initialDateTime: DateTime(
                                2023,
                                11,
                                31,
                                widget.selectedTime.hour,
                                widget.selectedTime.minute),
                            onDateTimeChanged: (val) {
                              final newTime =
                                  TimeOfDay(hour: val.hour, minute: val.minute);
                              widget.onTimeChanged(newTime);
                            },
                          )),
          ],
        ),
      ),
    );
  }
}

// class CustomTimePicker extends StatefulWidget {
//   CustomTimePicker({
//     super.key,
//     required this.hour,
//     required this.minute,
//     required this.timeFormat,
//     required this.onTimeChanged,
//   });
//   int hour;
//   int minute;
//   String timeFormat;
//   final Function(int, int, String) onTimeChanged;
//   @override
//   State<CustomTimePicker> createState() => _CustomTimePickerState();
// }

// class _CustomTimePickerState extends State<CustomTimePicker> {
//   void updateTime(int hour, int minute, String timeFormat) {
//     widget.onTimeChanged(hour, minute, timeFormat);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               decoration: BoxDecoration(
//                   color: AppColors.white,
//                   borderRadius: BorderRadius.circular(10)),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   NumberPicker(
//                     minValue: 0,
//                     maxValue: 12,
//                     value: widget.hour,
//                     zeroPad: true,
//                     infiniteLoop: true,
//                     itemWidth: 80,
//                     itemHeight: 60,
//                     onChanged: (value) {
//                       setState(() {
//                         widget.hour = value;
//                         widget.onTimeChanged(
//                             value, widget.minute, widget.timeFormat);
//                       });
//                     },
//                     textStyle:
//                         const TextStyle(color: AppColors.black, fontSize: 20),
//                     selectedTextStyle:
//                         const TextStyle(color: AppColors.black, fontSize: 30),
//                     decoration: const BoxDecoration(
//                       // color: AppColors.lightGrey,
//                       border: Border(
//                           top: BorderSide(
//                             color: AppColors.lightGrey, //here i changed
//                           ),
//                           bottom: BorderSide(color: AppColors.lightGrey)),
//                     ),
//                   ),
//                   NumberPicker(
//                     minValue: 0,
//                     maxValue: 59,
//                     value: widget.minute,
//                     zeroPad: true,
//                     infiniteLoop: true,
//                     itemWidth: 80,
//                     itemHeight: 60,
//                     onChanged: (value) {
//                       setState(() {
//                         widget.minute = value;
//                         widget.onTimeChanged(
//                             widget.hour, value, widget.timeFormat);
//                       });
//                     },
//                     textStyle:
//                         const TextStyle(color: AppColors.black, fontSize: 20),
//                     selectedTextStyle:
//                         const TextStyle(color: AppColors.black, fontSize: 30),
//                     decoration: const BoxDecoration(
//                       border: Border(
//                           top: BorderSide(
//                             color: AppColors.lightGrey,
//                           ),
//                           bottom: BorderSide(color: AppColors.lightGrey)),
//                     ),
//                   ),
//                   Column(
//                     children: [
//                       const SizedBox(
//                         height: 60,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             widget.timeFormat = "AM";
//                             widget.onTimeChanged(
//                                 widget.hour, widget.minute, "AM");
//                           });
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 10),
//                           decoration: BoxDecoration(
//                               color: widget.timeFormat == "AM"
//                                   ? AppColors.lightGrey
//                                   : AppColors.white,
//                               border: Border.all(
//                                 color: widget.timeFormat == "AM"
//                                     ? AppColors.lightGrey
//                                     : AppColors.white,
//                               )),
//                           child: const TextWidget(
//                             text: "AM",
//                             color: AppColors.black,
//                             fontSize: 24,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             widget.timeFormat = "PM";
//                             widget.onTimeChanged(
//                                 widget.hour, widget.minute, "PM");
//                           });
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 10),
//                           decoration: BoxDecoration(
//                             color: widget.timeFormat == "PM"
//                                 ? AppColors.lightGrey
//                                 : AppColors.white,
//                             border: Border.all(
//                               color: widget.timeFormat == "PM"
//                                   ? AppColors.lightGrey
//                                   : AppColors.white,
//                             ),
//                           ),
//                           child: const TextWidget(
//                               text: "PM", color: AppColors.black, fontSize: 24),
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
