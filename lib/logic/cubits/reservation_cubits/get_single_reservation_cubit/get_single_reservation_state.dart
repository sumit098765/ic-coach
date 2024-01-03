import 'package:equatable/equatable.dart';

import '../../../../domain/models/reservation_model/get_single_reservation_model.dart';


class GetSingleReservatioState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetSingleReservatioLodaingState extends GetSingleReservatioState {}

class GetSingleReservatioLoadedState extends GetSingleReservatioState {
  final GetSingleReservationModel getSingleReservation;
  // final GetSingleReservationModel secondModle;
  GetSingleReservatioLoadedState(this.getSingleReservation);
  @override
  List<Object?> get props => [getSingleReservation];
}

class GetSingleReservatioErrorState extends GetSingleReservatioState {
  final String message;
  GetSingleReservatioErrorState({required this.message});
}
