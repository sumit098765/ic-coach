import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../cubits/unavailibility_cubit/get_unavailibility_cubit/get_unavailibility_cubit.dart';

class CreateUnavailibilityEvent extends Equatable {
  const CreateUnavailibilityEvent();

  @override
  List<Object> get props => [];
}

class CreateUnavailibilityInitailEvent extends CreateUnavailibilityEvent {
  @override
  List<Object> get props => [];
}

class CreateUnavailibilityLoadedEvent extends CreateUnavailibilityEvent {
  final String coachId;
  final String selectedDate;
  final int startTime;
  final int endTime;
  final BuildContext myContext;
  bool showBottomSheet;
  final GetUnavailibilityCubit getUnavailibilityCubit;
  final bool isBlock;

   CreateUnavailibilityLoadedEvent(
      this.coachId,
      this.selectedDate,
      this.startTime,
      this.endTime,
      this.myContext,
      this.getUnavailibilityCubit,
      this.isBlock,{required this.showBottomSheet});
  @override
  List<Object> get props => [
        coachId,
        selectedDate,
        startTime,
        endTime,
        myContext,
        getUnavailibilityCubit,
        isBlock,showBottomSheet
      ];
}
