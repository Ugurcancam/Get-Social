import 'dart:async';

import 'package:etkinlikapp/features/auth/providers/user_provider.dart';
import 'package:etkinlikapp/features/event_room/domain/models/event_rooms_model.dart';
import 'package:etkinlikapp/features/event_room/state/bloc/event_detail/event_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class EventRoomDetail extends StatefulWidget {
  final EventRoomModel event;
  const EventRoomDetail({required this.event, super.key});

  @override
  State<EventRoomDetail> createState() => _EventRoomDetailState();
}

class _EventRoomDetailState extends State<EventRoomDetail> {
  String mapTheme = '';
  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context).loadString('assets/json/dark_map_theme.json').then((value) {
      mapTheme = value;
    });
  }

  final Completer<GoogleMapController> googleMapController = Completer();
  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<UserProvider>(context).uid;
    double anaResimHeight = 350;
    double containerHeight = 90;
    final top = anaResimHeight - (containerHeight / 2);
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 5, 19, 1),
      body: BlocBuilder<EventDetailBloc, EventDetailState>(
        builder: (context, state) {
          if (state is UserisCreatorState) {
            Text('You are the creator of this event');
          } else if (state is UserisNotCreatorState) {
            Text('You are not the creator of this event. İstek gönder');
          } else if (state is UserisApprovedState) {
            Text('You are approved for this event');
          } else if (state is UserisPendingApproval) {
            Text('You are pending approval for this event');
          }
          return Container();
        },
      ),
    );
  }
}
