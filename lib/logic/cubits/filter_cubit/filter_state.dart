import 'package:equatable/equatable.dart';
import 'package:instacoach/domain/models/reservation_model/filter_model.dart';

class FilterState1 extends Equatable {
  @override
  List<Object?> get props => [];
}

class FilterLodaingState extends FilterState1 {}

class FilterLoadedState extends FilterState1 {
  final FilterModel getAllReservation;
  FilterLoadedState(this.getAllReservation);
  @override
  List<Object?> get props => [getAllReservation];
}

class FilterEmptyState extends FilterState1 {
  final String massage;
  FilterEmptyState(this.massage);
  @override
  List<Object?> get props => [massage];
}

class FilterErrorState extends FilterState1 {
  final String message;
  FilterErrorState({required this.message});
}
