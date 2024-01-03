import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instacoach/domain/repositories/api_repositories.dart';

import 'create_unavailibility_event.dart';
import 'create_unavailibility_state.dart';

class CreateUnavailibilityBloc
    extends Bloc<CreateUnavailibilityEvent, CreateUnavailibilityState> {
  ApiServices apiServices;
  CreateUnavailibilityBloc(this.apiServices)
      : super(CreateUnavailibilityInitialState()) {
    on<CreateUnavailibilityInitailEvent>(
        (event, emit) => emit(CreateUnavailibilityInitialState()));
    on<CreateUnavailibilityLoadedEvent>((event, emit) async {
      emit(CreateUnavailibilityLoadingState());
      try {
        final data = await apiServices.unAvailibilityRepository(event.coachId,
            event.selectedDate, event.startTime, event.endTime, event.isBlock);
        //log("data in ovrride bloc ${data.data!.data!.schedule!.startTime == 0}");
       // log("IS VLOCKED ${event.isBlock}");
        if (data.data!.data!.startTime != 0 &&
            data.data!.data!.endTime != 2400 ) {
          emit(CreateUnavailibilityLoadedState(data.data!,showBottomSheet: event.showBottomSheet,));
          log("ovrride successful state");

          await event.getUnavailibilityCubit
              .loadOverrides(event.showBottomSheet,event.coachId, event.selectedDate,);
        } else if (data.data!.data!.schedule!.startTime == 0 &&
            data.data!.data!.schedule!.endTime == 2400 ) {
          emit(CreateUnavailibilityForWholeDayLoadedState(data.data!));
          log("ovrride UNAVIALABLE FOR WHOLE DAY successful state");
          await event.getUnavailibilityCubit
              .loadOverrides(event.showBottomSheet,event.coachId, event.selectedDate);
        }
      } catch (e) {
        log("ovvride bloc error $e");
        emit(CreateUnavailibilityErrorState(e.toString()));
      }
    });
  }
}
