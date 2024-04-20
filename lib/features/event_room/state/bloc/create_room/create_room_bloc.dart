import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:etkinlikapp/core/services/il_ilce_service.dart';
import 'package:etkinlikapp/features/event_room/domain/models/event_categories_model.dart';
import 'package:etkinlikapp/features/event_room/domain/services/event_categories_service.dart';

part 'create_room_event.dart';
part 'create_room_state.dart';

class CreateRoomBloc extends Bloc<CreateRoomEvent, CreateRoomState> {
  final EventCategoriesService eventCategoriesService;
  final ProvinceService provinceService;

  CreateRoomBloc()
      : eventCategoriesService = EventCategoriesService(),
        provinceService = ProvinceService(),
        super(CreateRoomInitial()) {
    on<FetchDataEvent>(fetchDataEvent);
  }

  FutureOr<void> fetchDataEvent(FetchDataEvent event, Emitter<CreateRoomState> emit) async {
    emit(CreateRoomLoading());
    try {
      final eventCategoriesData = await eventCategoriesService.getEventCategories();
      final provinces = await provinceService.getProvinces();
      emit(CreateRoomSuccess(eventCategoriesData: eventCategoriesData, provinces: provinces));
    } catch (e) {
      emit(CreateRoomFailure(error: e.toString()));
    }
  }
}
