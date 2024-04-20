import 'package:etkinlikapp/features/event_room/domain/services/event_room_service.dart';
import 'package:etkinlikapp/features/event_room/screens/sdfsf.dart';
import 'package:etkinlikapp/features/event_room/screens/yeni.dart';
import 'package:flutter/material.dart';

class EventRooms extends StatelessWidget {
  const EventRooms({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Rooms'),
      ),
      body: FutureBuilder(
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
                      MaterialPageRoute<EventDetail>(
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
    );
  }
}
