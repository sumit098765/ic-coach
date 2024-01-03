import 'package:equatable/equatable.dart';
import 'package:instacoach/domain/models/notification_models/get_notify_count_model.dart';

class GetNotifyCountState extends Equatable {
  const GetNotifyCountState();

  @override
  List<Object> get props => [];
}

class GetNotifyCountInitialState extends GetNotifyCountState {}

class GetNotifyCountLoadingState extends GetNotifyCountState {}

class GetNotifyCountLoadedState extends GetNotifyCountState {
  final GetNotifyCountModel notifyCount;

  const GetNotifyCountLoadedState(this.notifyCount);
  @override
  List<Object> get props => [notifyCount];
}

class GetNotifyCountEmptyState extends GetNotifyCountState {
  final String message;

  const GetNotifyCountEmptyState(this.message);
  @override
  List<Object> get props => [message];
  
}

class GetNotifyCountErrorState extends GetNotifyCountState {
  final String message;

  const GetNotifyCountErrorState(this.message);
  @override
  List<Object> get props => [message];
  
}
