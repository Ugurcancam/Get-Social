import 'dart:async';

import 'package:codegen/gen/colors.gen.dart';
import 'package:etkinlikapp/features/auth/providers/user_provider.dart';
import 'package:etkinlikapp/features/event_room/domain/models/event_rooms_model.dart';
import 'package:etkinlikapp/features/event_room/domain/services/event_room_service.dart';
import 'package:etkinlikapp/features/event_room/screens/message/messages_view.dart';
import 'package:etkinlikapp/features/event_room/screens/pending_approval_users.dart';
import 'package:etkinlikapp/features/event_room/state/bloc/event_detail/event_detail_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

part 'event_room_detail_subview.dart';
part 'event_room_detail_mixin.dart';

class EventRoomDetail extends StatefulWidget {
  final EventRoomModel event;
  const EventRoomDetail({required this.event, super.key});
  @override
  State<EventRoomDetail> createState() => _EventRoomDetailState();
}

class _EventRoomDetailState extends State<EventRoomDetail> with EventRoomDetailMixin {
  @override
  Widget build(BuildContext context) {
    double anaResimHeight = 350;
    double containerHeight = 90;
    final top = anaResimHeight - (containerHeight / 2);
    return Scaffold(
      //backgroundColor: Color.fromRGBO(0, 5, 19, 1),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Etkinlik Detayı', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: share,
          ),
        ],
      ),
      body: BlocBuilder<EventDetailBloc, EventDetailState>(
        bloc: _eventRoomDetailBloc,
        builder: (context, state) {
          if (state is UserisCreatorState) {
            return UserIsCreatorUI(anaResimHeight: anaResimHeight, widget: widget, top: top, containerHeight: containerHeight, googleMapController: googleMapController);
          } else if (state is UserisNotCreatorState) {
            return UserisNotCreatorUI(anaResimHeight: anaResimHeight, top: top, containerHeight: containerHeight, widget: widget, eventRoomService: eventRoomService, uid: uid, nameSurname: nameSurname);
          } else if (state is UserisApprovedState) {
            return UserisApprovedUI(anaResimHeight: anaResimHeight, top: top, containerHeight: containerHeight, widget: widget, googleMapController: googleMapController);
          } else if (state is UserisPendingApprovalState) {
            return UserisPendingUI(anaResimHeight: anaResimHeight, top: top, containerHeight: containerHeight, widget: widget);
          }
          return Container();
        },
      ),
    );
  }
}
