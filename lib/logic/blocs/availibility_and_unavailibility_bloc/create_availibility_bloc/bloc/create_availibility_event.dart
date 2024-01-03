part of 'create_availibility_bloc.dart';

class CreateAvailibilityEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateAvailibilityInitailEvent extends CreateAvailibilityEvent {
  @override
  List<Object> get props => [];
}

class CreateAvailibilityCreatedEvent extends CreateAvailibilityEvent {
  final String coachId;
  final String startDate;
  final String day;
  final String startTime;
  final String endTime;
  final GetAvailibilityCubit getAvailibilityCubit;
  CreateAvailibilityCreatedEvent(
      this.coachId, this.startDate, this.day, this.startTime, this.endTime,this.getAvailibilityCubit);
  @override
  List<Object> get props => [coachId,startDate,day,startTime,endTime,getAvailibilityCubit];
}
