import 'package:etkinlikapp/features/event_room/domain/models/event_rooms_model.dart';
import 'package:flutter/material.dart';

class PendingApprovalUsersView extends StatefulWidget {
  final EventRoomModel event;
  const PendingApprovalUsersView({required this.event, super.key});

  @override
  State<PendingApprovalUsersView> createState() => _PendingApprovalUsersViewState();
}

class _PendingApprovalUsersViewState extends State<PendingApprovalUsersView> {
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
              trailing: IconButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  // Approve user
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
