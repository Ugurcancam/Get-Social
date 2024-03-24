import 'package:etkinlikapp/features/auth/providers/user_provider.dart';
import 'package:etkinlikapp/features/event_room/domain/models/event_rooms_model.dart';
import 'package:etkinlikapp/features/profile/domain/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserEventRooms extends StatelessWidget {
  const UserEventRooms({super.key});

  @override
  Widget build(BuildContext context) {
    String? uid = Provider.of<UserProvider>(context).uid;
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: UserService().getUsersEventRooms(uid!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (snapshot.hasData) {
              List<EventRoomModel> eventRoomData = snapshot.data as List<EventRoomModel>;

              return Container(
                height: 500,
                child: ListView.builder(
                  itemCount: eventRoomData.length,
                  itemBuilder: (context, index) {
                    final eventRoom = eventRoomData[index];
                    return ListTile(
                      title: Text(
                        eventRoom.eventName,
                      ),
                    );
                  },
                ),
              );
            }
          }
          return const Center(child: Text('No data'));
        },
      ),
    );
    ;
  }
}
