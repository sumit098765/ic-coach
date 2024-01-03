import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reset_filter_state.dart';

class ResetFilterCubit extends Cubit<ResetFilterState> {
  ResetFilterCubit() : super(ResetFilterInitial());
  resetFilter() {
    emit(ResetFilterInitial());
    emit(ResetFilterDone());
  }

  increasePageNumber() {
    emit(PageIncreasedState());
  }
}
