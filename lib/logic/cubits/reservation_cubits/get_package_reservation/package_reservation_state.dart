import 'package:equatable/equatable.dart';

import '../../../../domain/models/reservation_model/get_single_package_model.dart';



class GetSinglePackageReservatioState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetSinglePackageReservatioLodaingState extends GetSinglePackageReservatioState {}

class GetSinglePackageReservatioLoadedState extends GetSinglePackageReservatioState {
  final ReservationPackageModel reservationPackage;
  // final GetSingleReservationModel secondModle;
  GetSinglePackageReservatioLoadedState(this.reservationPackage);
  @override
  List<Object?> get props => [reservationPackage];
}

class GetSinglePackageReservatioErrorState extends GetSinglePackageReservatioState {
  final String message;
  GetSinglePackageReservatioErrorState({required this.message});
}
