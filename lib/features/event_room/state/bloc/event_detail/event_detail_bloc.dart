import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:etkinlikapp/features/event_room/domain/models/event_rooms_model.dart';

part 'event_detail_event.dart';
part 'event_detail_state.dart';

class EventDetailBloc extends Bloc<EventDetailEvent, EventDetailState> {
  final EventRoomModel eventRoom;
  EventDetailBloc(this.eventRoom) : super(EventDetailInitial()) {
    on<GetEventDetail>(getEventDetail);
  }

  FutureOr<void> getEventDetail(GetEventDetail event, Emitter<EventDetailState> emit) {
    print("event id ${event.uid}");
    print("eventroom id ${eventRoom.creatorUid}");
    if (event.uid == eventRoom.creatorUid) {
      emit(UserisCreatorState());
    } else if (eventRoom.pendingApprovalUsers.any((user) => user.uid == event.uid)) {
      emit(UserisPendingApprovalState());
    } else if (eventRoom.approvedUsers.any((user) => user.uid == event.uid)) {
      emit(UserisApprovedState());
    } else if (event.uid != eventRoom.creatorUid) {
      emit(UserisNotCreatorState());
    }

    print(state);
  }
}
