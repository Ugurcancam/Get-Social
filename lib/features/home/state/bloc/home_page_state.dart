part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class HomePageInitial extends HomePageState {}

class HomePageLoading extends HomePageState {}

class HomePageLoaded extends HomePageState {
  final UserModel user;
  final List<EventRoomModel> eventRooms;

  const HomePageLoaded({required this.user, required this.eventRooms});

  @override
  List<Object> get props => [user, eventRooms];
}

class HomePageErrorState extends HomePageState {
  final String message;

  const HomePageErrorState({required this.message});
}
