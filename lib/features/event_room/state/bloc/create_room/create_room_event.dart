part of 'create_room_bloc.dart';

abstract class CreateRoomEvent extends Equatable {
  const CreateRoomEvent();

  @override
  List<Object> get props => [];
}

class FetchDataEvent extends CreateRoomEvent {}
