import 'package:etkinlikapp/features/event_room/domain/services/event_room_service.dart';
import 'package:flutter/material.dart';

class EventsByCategoryView extends StatefulWidget {
  const EventsByCategoryView({super.key});

  @override
  State<EventsByCategoryView> createState() => _EventsByCategoryViewState();
}

class _EventsByCategoryViewState extends State<EventsByCategoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: EventRoomService().getEventRoomsByCategory(category: 'Eğlence'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final events = snapshot.data;
            return ListView.builder(
              itemCount: events!.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Container(
                  padding: EdgeInsets.all(10.0),
                  height: 120,
                  child: Card(
                    child: Row(
                      children: <Widget>[
                        Image.network(
                          'https://source.unsplash.com/random/200x200?sig=1',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(event.eventName, style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(event.eventTime),
                              Text('description'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
