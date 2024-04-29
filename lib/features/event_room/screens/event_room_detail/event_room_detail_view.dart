import 'dart:async';

import 'package:etkinlikapp/core/constants/constants.dart';
import 'package:etkinlikapp/core/widgets/custom_sizedbox_height.dart';
import 'package:etkinlikapp/features/auth/providers/user_provider.dart';
import 'package:etkinlikapp/features/event_room/domain/models/event_rooms_model.dart';
import 'package:etkinlikapp/features/event_room/domain/services/event_room_service.dart';
import 'package:etkinlikapp/features/event_room/screens/message/messages_view.dart';
import 'package:etkinlikapp/features/event_room/screens/pending_approval_users.dart';
import 'package:etkinlikapp/features/event_room/state/bloc/event_detail/event_detail_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_act/slide_to_act.dart';

part 'event_room_detail_subview.dart';
part 'event_room_detail_mixin.dart';

class EventRoomDetail extends StatefulWidget {
  final EventRoomModel event;
  const EventRoomDetail({required this.event, super.key});

  @override
  State<EventRoomDetail> createState() => _EventRoomDetailState();
}

class _EventRoomDetailState extends State<EventRoomDetail> with EventRoomDetailMixin {
  String mapTheme = '';
  late EventDetailBloc _eventRoomDetailBloc;
  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context).loadString('assets/json/dark_map_theme.json').then((value) {
      mapTheme = value;
    });
    _eventRoomDetailBloc = EventDetailBloc(widget.event);
    _eventRoomDetailBloc.add(GetEventDetail(uid: uid));
  }

  final Completer<GoogleMapController> googleMapController = Completer();
  @override
  Widget build(BuildContext context) {
    double anaResimHeight = 350;
    double containerHeight = 90;
    final top = anaResimHeight - (containerHeight / 2);
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 5, 19, 1),
      body: BlocBuilder<EventDetailBloc, EventDetailState>(
        bloc: _eventRoomDetailBloc,
        builder: (context, state) {
          if (state is UserisCreatorState) {
            return UserIsCreatorUI(anaResimHeight: anaResimHeight, widget: widget, top: top, containerHeight: containerHeight, mapTheme: mapTheme, googleMapController: googleMapController);
          } else if (state is UserisNotCreatorState) {
            return UserisNotCreatorUI(anaResimHeight: anaResimHeight, top: top, containerHeight: containerHeight, widget: widget, eventRoomService: eventRoomService, uid: uid, nameSurname: nameSurname);
          } else if (state is UserisApprovedState) {
            return UserisApprovedUI(anaResimHeight: anaResimHeight, top: top, containerHeight: containerHeight, widget: widget, mapTheme: mapTheme, googleMapController: googleMapController);
          } else if (state is UserisPendingApprovalState) {
            return UserisPendingUI(anaResimHeight: anaResimHeight, top: top, containerHeight: containerHeight, widget: widget);
          }
          return Container();
        },
      ),
    );
  }
}
