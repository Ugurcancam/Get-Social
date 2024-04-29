import 'package:etkinlikapp/features/event_room/domain/models/event_rooms_model.dart';
import 'package:etkinlikapp/features/event_room/domain/services/event_room_service.dart';
import 'package:flutter/material.dart';

class PendingApprovalUsersView extends StatefulWidget {
  final EventRoomModel event;
  const PendingApprovalUsersView({required this.event, super.key});

  @override
  State<PendingApprovalUsersView> createState() => _PendingApprovalUsersViewState();
}

class _PendingApprovalUsersViewState extends State<PendingApprovalUsersView> {
  final EventRoomService _eventRoomService = EventRoomService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Approval Users'),
      ),
      body: ListView.builder(
        itemCount: widget.event.pendingApprovalUsers.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(widget.event.pendingApprovalUsers[index].namesurname),
              leading: IconButton(
                  onPressed: () {
                    _eventRoomService.approveUser(
                      docId: widget.event.docId!,
                      uid: widget.event.pendingApprovalUsers[index].uid,
                      namesurname: widget.event.pendingApprovalUsers[index].namesurname,
                    );
                  },
                  icon: Icon(Icons.check)),
              trailing: IconButton(
                onPressed: () {
                  _eventRoomService.denyApproval(
                    docId: widget.event.docId!,
                    uid: widget.event.pendingApprovalUsers[index].uid,
                  );
                },
                icon: Icon(Icons.close),
              ),
            ),
          );
        },
      ),
    );
  }
}
