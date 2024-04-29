import 'package:etkinlikapp/features/event_room/domain/services/event_room_service.dart';
import 'package:etkinlikapp/features/event_room/screens/event_room_detail/event_room_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class EventRooms extends StatefulWidget {
  const EventRooms({Key? key});

  @override
  State<EventRooms> createState() => _EventRoomsState();
}

class _EventRoomsState extends State<EventRooms> {
  Future<void> refresh() async {
    await EventRoomService().getEventRooms();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidPullToRefresh(
        onRefresh: refresh,
        child: FutureBuilder(
          future: EventRoomService().getEventRooms(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              final eventRooms = snapshot.data!;
              return ListView.builder(
                itemCount: eventRooms.length,
                itemBuilder: (context, index) {
                  final eventRoom = eventRooms[index];
                  return ListTile(
                    title: Text(eventRoom.eventName),
                    subtitle: Text(eventRoom.eventDate),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<EventRoomDetail>(
                          builder: (context) => EventRoomDetail(event: eventRoom),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
