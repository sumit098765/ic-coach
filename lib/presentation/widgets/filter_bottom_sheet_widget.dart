import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instacoach/logic/cubits/reset_filter/reset_filter_cubit.dart';
import 'package:instacoach/presentation/widgets/text_widget.dart';
import '../../logic/cubits/filter_cubit/filter_cubit.dart';
import '../../utils/constants/colors.dart';
import 'gradient_button.dart';

class FilterBottomSheetWidget {
  static Map<String, String> statusMapping = {
    "scheduled": "Upcoming",
    "completed": "Completed",
    "cancelled": "Cancelled",
  };

  static String? selectedValue;

  static showSheet(BuildContext context, String coachId,
      Function(String?) onFilterSelected, int pageNumber) {
    // log("statusMapping $statusMapping");
    // log("selectedValue $selectedValue");
    showModalBottomSheet<void>(
      useRootNavigator: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50.sp,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            text: "Filters",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(3.sp),
                              decoration: const BoxDecoration(
                                  color: AppColors.black,
                                  shape: BoxShape.circle),
                              child: const Icon(
                                Icons.close,
                                weight: 12,
                                color: AppColors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                      color: AppColors.lightBlue,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            final apiStatus = [
                              "scheduled",
                              "completed",
                              "cancelled"
                            ];
                            final alternatives = [
                              "Upcoming",
                              "Completed",
                              "Cancelled"
                            ];
                            final uiStatus = statusMapping[apiStatus[index]] ??
                                alternatives[index];

                            return Column(
                              children: [
                                RadioListTile(
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: TextWidget(
                                    text: uiStatus,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  value: apiStatus[index],
                                  groupValue: selectedValue ?? 'scheduled',
                                  onChanged: (Object? value) {
                                    setState(() {
                                      selectedValue = value as String?;

                                      log("Ds,jfsdkjfsdddsdgadg$selectedValue");
                                    });
                                  },
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: AppColors.lightBlue,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: AppColors.lightBlue,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: gradientButton1(
                      
                        context: context,
                        rWidth: 390,
                        rHeight: 44,
                        btnText: "Apply Filter",
                        onPress: () async {
                          BlocProvider.of<ResetFilterCubit>(context)
                              .resetFilter();
                          BlocProvider.of<FilterCubit>(context)
                              .fetchAccToFilter(
                                  coachId, selectedValue.toString(), 1);

                          onFilterSelected(selectedValue);
                          Navigator.pop(context);
                        },
                        color: AppColors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
