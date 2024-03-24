import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlikapp/features/auth/providers/user_provider.dart';
import 'package:etkinlikapp/features/event_room/domain/models/event_rooms_model.dart';
import 'package:etkinlikapp/features/event_room/domain/services/event_room_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventRoomDetail extends StatelessWidget {
  final EventRoomModel? eventRoomData;
  EventRoomDetail({super.key, this.eventRoomData});

  final EventRoomService _eventRoomService = EventRoomService();

  @override
  Widget build(BuildContext context) {
    String? uid = Provider.of<UserProvider>(context).uid;
    String? namesurname = Provider.of<UserProvider>(context).namesurname;
    final Stream<QuerySnapshot> _eventRoomsStream = FirebaseFirestore.instance.collection('event_rooms').snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text(eventRoomData!.eventName),
      ),
      body: eventRoomData!.creatorUid == uid
          ? StreamBuilder<QuerySnapshot>(
              stream: _eventRoomsStream,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    Container(
                      height: MediaQuery.sizeOf(context).height * 0.6,
                      child: ListView.builder(
                        itemCount: eventRoomData!.approvedUsers.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              eventRoomData!.approvedUsers[index].namesurname,
                            ),
                            subtitle: Container(
                              height: 100,
                              child: ListView.builder(
                                itemCount: eventRoomData!.categories.length,
                                itemBuilder: (context, index) {
                                  return Text(eventRoomData!.categories[index].name);
                                },
                              ),
                            ),
                            trailing: Text('admin'),
                          );
                        },
                      ),
                    ),
                    Container(
                      height: MediaQuery.sizeOf(context).height * 0.3,
                      child: ListView.builder(
                        itemCount: eventRoomData!.pendingApprovalUsers.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(top: 10, right: 10),
                            child: ListTile(
                              title: Text(
                                eventRoomData!.pendingApprovalUsers[index].namesurname,
                              ),
                              leading: IconButton(
                                  onPressed: () {
                                    _eventRoomService.approveUser(
                                      docId: eventRoomData!.docId!,
                                      uid: eventRoomData!.pendingApprovalUsers[index].uid!,
                                      namesurname: eventRoomData!.pendingApprovalUsers[index].namesurname!,
                                    );
                                  },
                                  icon: Icon(Icons.check)),
                              trailing: IconButton(
                                  onPressed: () {
                                    _eventRoomService.denyApproval(
                                      docId: eventRoomData!.docId!,
                                      uid: eventRoomData!.pendingApprovalUsers[index].uid!,
                                    );
                                  },
                                  icon: Icon(Icons.close)),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              })
          : Column(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  child: ListView.builder(
                    itemCount: eventRoomData!.approvedUsers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          eventRoomData!.approvedUsers[index].namesurname,
                        ),
                        subtitle: Container(
                          height: 100,
                          child: ListView.builder(
                            itemCount: eventRoomData!.categories.length,
                            itemBuilder: (context, index) {
                              return Text(eventRoomData!.categories[index].name);
                            },
                          ),
                        ),
                        trailing: Text('istek'),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _eventRoomService.addPendingUser(docId: eventRoomData!.docId!, uid: uid!, namesurname: namesurname!);
                  },
                  child: Text('Katıl'),
                ),
              ],
            ),
    );
  }
}
