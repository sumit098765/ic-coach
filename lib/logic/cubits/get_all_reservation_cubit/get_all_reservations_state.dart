part of 'get_all_reservations_cubit.dart';

class GetAllReservationsState extends Equatable {
  const GetAllReservationsState();

  @override
  List<Object> get props => [];
}

class GetAllReservationsInitial extends GetAllReservationsState {}

class GetAllReservationLoadingState extends GetAllReservationsState {}

class GetAllReservationLoadedState extends GetAllReservationsState {
  final List reservations;

  const GetAllReservationLoadedState(this.reservations);
  @override
  List<Object> get props => [reservations];
}

class GetAllReservatioLoadedEmptyState extends GetAllReservationsState {
  final String message;

  const GetAllReservatioLoadedEmptyState(this.message);
  @override
  List<Object> get props => [message];
}

class ErrorState extends GetAllReservationsState {
  final String message;
  const ErrorState(this.message);
}
