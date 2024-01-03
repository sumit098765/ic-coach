// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instacoach/logic/cubits/avaibility_cubit/delete_availibility/cubit/delete_availibility_cubit.dart';
import 'package:instacoach/presentation/widgets/text_widget.dart';
import 'package:instacoach/utils/constants/colors.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../../../domain/models/availibility_model/get_availibility_model.dart';
import '../../../logic/blocs/availibility_and_unavailibility_bloc/create_availibility_bloc/bloc/create_availibility_bloc.dart';
import '../../../logic/cubits/avaibility_cubit/delete_availibility/cubit/delete_availibility_state.dart';
import '../../../logic/cubits/avaibility_cubit/get_availibility_cubit/get_availibility_cubit.dart';
import '../../../logic/cubits/avaibility_cubit/get_availibility_cubit/get_availibility_state.dart';
import '../../widgets/availibility_bottom_sheet.dart';
import '../../widgets/switch_widget.dart';

class AvailibilityScreen extends StatefulWidget {
  const AvailibilityScreen({super.key, this.coachId});
  final String? coachId;

  @override
  State<AvailibilityScreen> createState() => _AvailibilityScreenState();
}

class _AvailibilityScreenState extends State<AvailibilityScreen> {
  @override
  void initState() {
    BlocProvider.of<GetAvailibilityCubit>(context)
        .loadavailibilities(widget.coachId ?? "");
    //  dayavai.
    super.initState();
  }

  var dayavai;
  List<bool> daysStatus = List.generate(7, (index) => false);

  List<String> daysNames = [
    "Sundays",
    "Mondays",
    "Tuesdays",
    "Wednesdays",
    "Thursdays",
    "Fridays",
    "Saturdays"
  ];
  List<int> range = [];
  int? idToDelete;

  void showDatePickerModal(List existingTimeRange, int index) {
    List<String> enabledDays = [];

    log("enabledDays ${daysStatus[index]}");
    if (daysStatus[index]) {
      enabledDays.add(daysNames[index]);
      log("enabledDays $enabledDays");
    }

    DatePickerBottomSheetWidget.showModal(
      context,
      false,
      enabledDays,
      widget.coachId ?? "",
      existingTimeRanges: existingTimeRange,
    );
  }

  String _formatTime(int time) {
    String timeStr = time.toString().padLeft(4, '0');
    int hour = int.parse(timeStr.substring(0, 2));
    String period = (hour >= 12 && hour < 24) ? 'pm' : 'am';
    int adjustedHour = hour > 12 ? hour - 12 : hour;
    adjustedHour = adjustedHour == 0 ? 12 : adjustedHour;

    return '${adjustedHour.toString().padLeft(2, '0')}:${timeStr.substring(2, 4)} $period';
  }

  bool status = false;
  final RefreshController refreshController = RefreshController();
  void onRefresh() async {
    await BlocProvider.of<GetAvailibilityCubit>(context)
        .loadavailibilities(widget.coachId ?? "");
    refreshController.refreshCompleted();
  }

  final msg = BlocBuilder<CreateAvailibilityBloc, CreateAvailibilityState>(
      builder: (context, state) {
    if (state is CreateAvailibilityLoadingState) {
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
    return Scaffold(
      body: BlocListener<DeleteAvailibilityCubit, DeleteAvailibilityState>(
        listener: (context, state) {
          if (state is DeleteAvailibilityLoadedState) {
            Fluttertoast.showToast(msg: "Deleted Successfully");
          } else if (state is DeleteAvailibilityErrorState) {
            Fluttertoast.showToast(msg: state.message);
          }
        },
        child: BlocBuilder<GetAvailibilityCubit, GetAvailibilityState>(
          builder: (context, state) {
            if (state is GetAvailibilityLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.black,
                ),
              );
            } else if (state is GetAvailibilityLoadedState) {
              final availibilities = state.availibility;

              return SafeArea(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                            child: SmartRefresher(
                          controller: refreshController,
                          enablePullDown: true,
                          onRefresh: onRefresh,
                          header: const ClassicHeader(),
                          child: ListView.builder(
                            itemCount: 7,
                            itemBuilder: (context, index) {
                              final entry = availibilities
                                  .data!
                                  .coachCalAvailabilityData!
                                  .weeklyRanges!
                                  .days!
                                  .entries
                                  .elementAt(index);
                              final dayData = entry.value;
                              final List<List<int>> ranges = dayData
                                      .timeSlots?.values
                                      .map((slot) => slot.range!)
                                      .toList() ??
                                  [];

                              final dayAvailibilities = availibilities.data!
                                  .coachCalAvailabilityData!.availabilities;
                              dayavai = dayAvailibilities!.entries
                                  .elementAt(index)
                                  .value;
                              log("what is this comming ...................${dayAvailibilities.entries.elementAt(index).value}");
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 12, top: 20),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6),
                                          child: SwitchWidget(
                                              isVisible: false,
                                              textColor:
                                                  daysStatus[index] == false &&
                                                          ranges.isEmpty
                                                      ? AppColors.grey3
                                                      : AppColors.black,
                                              switchText: daysNames[index],
                                              switchColor:
                                                  AppColors.selectedBlue,
                                              initialStatus: dayAvailibilities
                                                  .entries
                                                  .elementAt(index)
                                                  .value,
                                              onChanged: (value) {
                                                setState(() {
                                                  daysStatus[index] = value;
                                                  if (!daysStatus[index]) {
                                                    for (final slot in dayData
                                                        .timeSlots!.values) {
                                                      if (slot.id != null) {
                                                        BlocProvider.of<
                                                                    DeleteAvailibilityCubit>(
                                                                context)
                                                            .deleteAvailibilities(
                                                                slot.id ?? 0,
                                                                context,
                                                                widget.coachId ??
                                                                    "");
                                                      }
                                                    }
                                                  }
                                                  if (value) {
                                                    daysStatus[index] == false
                                                        ? daysStatus[index] =
                                                            dayAvailibilities
                                                                .entries
                                                                .elementAt(
                                                                    index)
                                                                .value
                                                        : daysStatus[index];
                                                    showDatePickerModal(
                                                        ranges, index);
                                                  }
                                                });
                                                //}
                                              }),
                                        ),
                                        daysStatus[index] == false &&
                                                ranges.isEmpty
                                            ? Row(
                                                children: [
                                                  Container(
                                                    height: 42,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: AppColors.white,
                                                        boxShadow: const [
                                                          BoxShadow(
                                                              blurRadius: 1,
                                                              spreadRadius: 1,
                                                              color: AppColors
                                                                  .lightBlue)
                                                        ]),
                                                    child: const Center(
                                                      child: TextWidget(
                                                        text: "Unavailable",
                                                        color: AppColors.grey3,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: const Icon(
                                                      Icons.add,
                                                      size: 25,
                                                      color: AppColors.grey3,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : BlocBuilder<
                                                CreateAvailibilityBloc,
                                                CreateAvailibilityState>(
                                                builder: (context, state) {
                                                  if (state
                                                      is CreateAvailibilityLoadingState) {
                                                    return const Center(
                                                      child: TextWidget(
                                                          text: "Loading..."),
                                                    );
                                                  }
                                                  return Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      SizedBox(
                                                        width: 167.sp,
                                                        child: ListView.builder(
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            shrinkWrap: true,
                                                            itemCount:
                                                                ranges.length,
                                                            itemBuilder:
                                                                (context,
                                                                    rangeIndex) {
                                                              range = ranges[
                                                                  rangeIndex];

                                                              final String
                                                                  formattedStartTime =
                                                                  _formatTime(
                                                                      range[0]);

                                                              final String
                                                                  formattedEndTime =
                                                                  _formatTime(
                                                                      range[1]);

                                                              final String
                                                                  rangeString =
                                                                  '$formattedStartTime - $formattedEndTime';

                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            10),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        if (rangeIndex <
                                                                            ranges.length) {
                                                                          idToDelete = dayData
                                                                              .timeSlots
                                                                              ?.values
                                                                              .firstWhere((slot) => slot.range == ranges[rangeIndex], orElse: () => TimeSlot(id: null, range: null))
                                                                              .id;

                                                                          if (idToDelete !=
                                                                              null) {
                                                                            BlocProvider.of<DeleteAvailibilityCubit>(context).deleteAvailibilities(
                                                                                idToDelete ?? 0,
                                                                                context,
                                                                                widget.coachId ?? "");
                                                                            setState(() {
                                                                              daysStatus[index] = false;
                                                                              ranges.removeAt(rangeIndex);
                                                                            });
                                                                          }
                                                                        }
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(right: 7),
                                                                        child:
                                                                            Visibility(
                                                                          // visible:
                                                                          //     rangeIndex != 0,
                                                                          child:
                                                                              Image.asset(
                                                                            "assets/images/g1.png",
                                                                            height:
                                                                                24,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          42,
                                                                      width:
                                                                          150,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                          color: AppColors.white,
                                                                          boxShadow: const [
                                                                            BoxShadow(
                                                                                blurRadius: 1,
                                                                                spreadRadius: 1,
                                                                                color: AppColors.lightBlue)
                                                                          ]),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            TextWidget(
                                                                          text:
                                                                              rangeString,
                                                                          fontSize:
                                                                              12.sp,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            }),
                                                      ),
                                                      const SizedBox(
                                                        width: 6,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          daysStatus[index] ==
                                                                  false
                                                              ? daysStatus[
                                                                      index] =
                                                                  dayAvailibilities
                                                                      .entries
                                                                      .elementAt(
                                                                          index)
                                                                      .value
                                                              : daysStatus[
                                                                  index];
                                                          showDatePickerModal(
                                                              ranges, index);
                                                          // log("ranges ${ranges.isNotEmpty}");

                                                          // log("day status  ${daysStatus[index]}");
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 18),
                                                          child: Icon(
                                                            Icons.add,
                                                            size: 23.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      color: AppColors.lightBlue,
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        )),
                        const SizedBox(
                          height: 10,
                        ),
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
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                    //  msg,
                  ],
                ),
              );
            } else if (state is ErrorState) {
              return TextWidget(text: state.message);
            } else {
              return const TextWidget(text: "Something went wrong");
            }
          },
        ),
      ),
    );
  }
}
