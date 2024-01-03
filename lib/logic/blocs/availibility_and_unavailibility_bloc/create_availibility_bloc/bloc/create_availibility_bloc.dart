import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instacoach/domain/repositories/api_repositories.dart';
import 'package:instacoach/logic/cubits/avaibility_cubit/get_availibility_cubit/get_availibility_cubit.dart';

import '../../../../../domain/models/availibility_model/availibility_model.dart';

part 'create_availibility_event.dart';
part 'create_availibility_state.dart';

class CreateAvailibilityBloc
    extends Bloc<CreateAvailibilityEvent, CreateAvailibilityState> {
  ApiServices apiServices;
  CreateAvailibilityBloc(this.apiServices)
      : super(CreateAvailibilityInitialState()) {
    on<CreateAvailibilityInitailEvent>(
        (event, emit) => emit(CreateAvailibilityInitialState()));

    on<CreateAvailibilityCreatedEvent>((event, emit) async {
      emit(CreateAvailibilityLoadingState());
      try {
        final data = await apiServices.availibilityRepository(event.coachId,
            event.startDate, event.day, event.startTime, event.endTime);
        log("Data inside availibilty Bloc $data");
        if (data.data!.data != null) {
          emit(CreateAvailibilityCreatedState(data.data!));
          log("Created successfully");
          await event.getAvailibilityCubit.loadavailibilities(event.coachId);
        }
      } catch (e) {
        log("Error in Availibility Bloc $e");
        emit(CreateAvailibilityErrorState(e.toString()));
      }
    });
  }
}
