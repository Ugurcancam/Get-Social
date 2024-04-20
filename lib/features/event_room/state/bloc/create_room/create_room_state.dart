part of 'create_room_bloc.dart';

abstract class CreateRoomState extends Equatable {
  const CreateRoomState();

  @override
  List<Object> get props => [];
}

class CreateRoomInitial extends CreateRoomState {}

class CreateRoomLoading extends CreateRoomState {}

class CreateRoomSuccess extends CreateRoomState {
  final List<EventCategoriesModel> eventCategoriesData;
  final List<String> provinces;

  const CreateRoomSuccess({required this.eventCategoriesData, required this.provinces});

  @override
  List<Object> get props => [eventCategoriesData, provinces];
}

class CreateRoomFailure extends CreateRoomState {
  final String error;

  const CreateRoomFailure({required this.error});

  @override
  List<Object> get props => [error];
}
