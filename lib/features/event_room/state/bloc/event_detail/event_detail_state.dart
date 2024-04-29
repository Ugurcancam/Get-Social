part of 'event_detail_bloc.dart';

sealed class EventDetailState extends Equatable {
  const EventDetailState();

  @override
  List<Object> get props => [];
}

final class EventDetailInitial extends EventDetailState {}

// Kullanıcının odayı olusturan oldugu durum
final class UserisCreatorState extends EventDetailState {}

// Kullanıcının odayı oluşturan olmadığı, istek atabileceği durum
final class UserisNotCreatorState extends EventDetailState {}

// Kullanıcının odaya katılma isteği atıp beklediği durum
final class UserisPendingApprovalState extends EventDetailState {}

// Kullanıcının odaya katıldığı durum -- katılmıs olacak ama uid si creator uid ile aynı olmayacak
final class UserisApprovedState extends EventDetailState {}
