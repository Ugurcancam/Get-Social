part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

final class HomePageInitial extends HomePageState {}

final class HomePageLoading extends HomePageState {}

final class HomePageLoaded extends HomePageState {
  final UserModel user;
  final List<EventRoomModel> eventRooms;
  final List<String> provinces;

  const HomePageLoaded({required this.user, required this.eventRooms, required this.provinces});

  @override
  List<Object> get props => [user, eventRooms, provinces];
}

final class NoEventRoomFound extends HomePageState {
  final UserModel user;
  const NoEventRoomFound({required this.user});

  @override
  List<Object> get props => [user];
}

final class HomePageErrorState extends HomePageState {
  final String message;

  const HomePageErrorState({required this.message});
}
