import 'package:equatable/equatable.dart';
import 'package:instacoach/domain/models/notification_models/get_notify_model.dart';

class GetNotifyState extends Equatable {
  const GetNotifyState();

  @override
  List<Object> get props => [];
}

class GetNotifyInitialState extends GetNotifyState {}

class GetNotifyLoadingState extends GetNotifyState {}

class GetNotifyLoadedState extends GetNotifyState {
  final GetNotifyModel getNotify;

  const GetNotifyLoadedState(this.getNotify);
  @override
  List<Object> get props => [getNotify];
}

class GetNotifyEmptyState extends GetNotifyState {
  final String message;

  const GetNotifyEmptyState(this.message);
  @override
  List<Object> get props => [message];
}

class GetNotifyErrorState extends GetNotifyState {
  final String message;

  const GetNotifyErrorState(this.message);
  @override
  List<Object> get props => [message];
}
