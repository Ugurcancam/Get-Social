part of 'event_detail_bloc.dart';

sealed class EventDetailEvent extends Equatable {
  const EventDetailEvent();

  @override
  List<Object> get props => [];
}

class GetEventDetail extends EventDetailEvent {
  final String uid;
  const GetEventDetail({required this.uid});

  @override
  List<Object> get props => [uid];
}
