import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:etkinlikapp/core/services/il_ilce_service.dart';
import 'package:etkinlikapp/features/auth/domain/models/user_model.dart';
import 'package:etkinlikapp/features/event_room/domain/models/event_rooms_model.dart';
import 'package:etkinlikapp/features/event_room/domain/services/event_room_service.dart';
import 'package:etkinlikapp/features/profile/domain/services/user_service.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<GetHomePageData>(getHomePageData);
  }

  FutureOr<void> getHomePageData(GetHomePageData event, Emitter<HomePageState> emit) async {
    final userService = UserService();
    final eventRoomsService = EventRoomService();
    final ProvinceService provinceService = ProvinceService();
    try {
      emit(HomePageLoading());
      final user = await userService.getUserDetails(event.userEmail);
      final provinces = await provinceService.getProvinces();
      final eventRooms = await eventRoomsService.getEventRoomsByProvince(province: user!.province);
      if (eventRooms.isEmpty) {
        emit(NoEventRoomFound(user: user));
        return;
      }
      emit(HomePageLoaded(user: user, eventRooms: eventRooms, provinces: provinces));
    } catch (e) {
      emit(HomePageErrorState(message: e.toString()));
    }
  }
}
