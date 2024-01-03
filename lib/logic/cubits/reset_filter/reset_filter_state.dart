part of 'reset_filter_cubit.dart';

abstract class ResetFilterState extends Equatable {
  const ResetFilterState();

  @override
  List<Object> get props => [];
}

class ResetFilterInitial extends ResetFilterState {}

class ResetFilterDone extends ResetFilterState {}

class PageIncreasedState extends ResetFilterState {}
