import 'package:codegen/gen/assets.gen.dart';
import 'package:etkinlikapp/features/event_room/domain/services/event_room_service.dart';
import 'package:etkinlikapp/features/event_room/screens/event_room_detail/event_room_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EventsByCategoryView extends StatefulWidget {
  final String categoryName;
  const EventsByCategoryView({required this.categoryName, super.key});

  @override
  State<EventsByCategoryView> createState() => _EventsByCategoryViewState();
}

class _EventsByCategoryViewState extends State<EventsByCategoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: FutureBuilder(
        future: EventRoomService().getEventRoomsByCategory(category: widget.categoryName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Assets.images.noCategoryFound.path,
                      width: 180,
                      height: 180,
                    ),
                    const SizedBox(height: 50),
                    Text('Bu Kategoride Etkinlik Bulunmuyor.', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
              );
            }
            if (snapshot.hasData) {
              final events = snapshot.data;
              return ListView.builder(
                itemCount: events!.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EventRoomDetail(event: event))),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      height: 160,
                      child: Card(
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
                              child: Image.network(
                                'https://source.unsplash.com/random/200x200?sig=1',
                                width: 100,
                                height: 160,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(event.eventName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                  Divider(),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today),
                                      const SizedBox(width: 5),
                                      Text(event.eventDate),
                                      const SizedBox(width: 25),
                                      Icon(Icons.access_time),
                                      const SizedBox(width: 5),
                                      Text(event.eventTime),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on),
                                      const SizedBox(width: 5),
                                      Text('${event.province}, ${event.district}'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.data!.isEmpty) {
            return Center(child: Text('Veri yok'));
          }

          return Container();
        },
      ),
    );
  }
}
