import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instacoach/presentation/widgets/text_widget.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:time_range/time_range.dart';
import '../../../utils/constants/colors.dart';
import '../../widgets/gradient_button.dart';

class SessionRescheduleShBottomeetWidget {
  static showModal(BuildContext context) {
    showModalBottomSheet(
       useRootNavigator:true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Flexible(
            fit: FlexFit.loose,
            flex: 1,
            child: SizedBox(
                height: 605.sp,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        const TextWidget(
                          text: "Choose a new date & time",
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset("assets/images/cross.svg"))
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Divider(
                      thickness: 1,
                      color: AppColors.lightGrey,
                    ),
                    const SizedBox(
                        height: 600, child: SessionRescheduleScreen()),
                  ],
                )),
          ),
        );
      },
    );
  }
}

class SessionRescheduleScreen extends StatefulWidget {
  const SessionRescheduleScreen({Key? key}) : super(key: key);

  @override
  State<SessionRescheduleScreen> createState() =>
      _SessionRescheduleScreenState();
}

class _SessionRescheduleScreenState extends State<SessionRescheduleScreen> {
  final _defaultTimeRange = TimeRangeResult(
    const TimeOfDay(hour: 14, minute: 00),
    const TimeOfDay(hour: 15, minute: 00),
  );
  TimeRangeResult? _timeRange;

  @override
  void initState() {
    super.initState();
    _timeRange = _defaultTimeRange;
  }

  DateTime? today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDat) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    //log("time range ${_timeRange!.start}");
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TableCalendar(
            rowHeight: 50,
            selectedDayPredicate: (day) => isSameDay(day, today),
            headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronMargin: EdgeInsets.only(left: 60.sp),
                rightChevronMargin: EdgeInsets.only(right: 60.sp)),
            focusedDay: today!,
            firstDay: DateTime.now(),
            lastDay: DateTime.utc(2025),
            onDaySelected: _onDaySelected,
            calendarStyle: const CalendarStyle(
                isTodayHighlighted: false,
                selectedDecoration: BoxDecoration(
                    color: AppColors.black, shape: BoxShape.circle)),
          ),

          const SizedBox(height: 5),
          const Divider(
            thickness: 1,
            color: AppColors.lightGrey,
          ),
          const SizedBox(height: 10),

          TimeRange(
            textStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              color: AppColors.black,
            ),
            activeTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
            borderColor: AppColors.black,
            activeBorderColor: AppColors.black,
            backgroundColor: AppColors.tranparent,
            activeBackgroundColor: AppColors.black,
            firstTime: const TimeOfDay(hour: 8, minute: 00),
            lastTime: const TimeOfDay(hour: 20, minute: 00),
            initialRange: _timeRange,
            timeStep: 30,
            timeBlock: 30,
            onRangeCompleted: (range) => setState(() => _timeRange = range),
            onFirstTimeSelected: (startHour) {},
          ),
          const SizedBox(height: 10),
          const Divider(
            thickness: 1,
            color: AppColors.lightGrey,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Image.asset("assets/images/earth.png"),
              const SizedBox(
                width: 0,
              ),
              const TextWidget(
                text: "Pacific Time - US & Canada (2:49pm)",
                color: AppColors.selectedBlue,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              )
            ],
          ),
        
           const SizedBox(height: 25),
          gradientButton1(
              context: context,
              rWidth: 390,
              rHeight: 44,
              btnText: "Reschedule Request",
              color: AppColors.selectedBlue,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              onPress: () {
                // CancelBottomSheetWidget.showModal(context, "Reschedule request",
                //     "Are you sure want to\nReschedule?" );
              })
          // if (_timeRange != null)
          //   Padding(
          //     padding: const EdgeInsets.only(top: 8.0, left: leftPadding),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: <Widget>[
          //         Text(
          //           'Selected Range: ${_timeRange!.start.format(context)} - ${_timeRange!.end.format(context)}',
          //           style: const TextStyle(fontSize: 20, color: dark),
          //         ),
          //         const SizedBox(height: 20),
          //         MaterialButton(
          //           onPressed: () =>
          //               setState(() => _timeRange = _defaultTimeRange),
          //           color: orange,
          //           child: const Text('Default'),
          //         )
          //       ],
          //     ),
          //   ),
        ],
      ),
    );
  }
}
