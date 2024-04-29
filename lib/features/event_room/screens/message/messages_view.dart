import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlikapp/core/constants/constants.dart';
import 'package:etkinlikapp/features/auth/providers/user_provider.dart';
import 'package:etkinlikapp/features/event_room/domain/models/event_rooms_model.dart';
import 'package:etkinlikapp/features/event_room/domain/services/event_room_service.dart';
import 'package:etkinlikapp/features/event_room/domain/view_models/message_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
part 'messages_mixin.dart';

class Messages extends StatefulWidget {
  final EventRoomModel event;
  const Messages({Key? key, required this.event}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> with MessagesMixin {
  // get logged in users uid from firebase firestore

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mesajlar'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _eventRoomService.getMessagesStream(docId: widget.event.docId!),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) return const Text('Something went wrong');
          if (snapshot.connectionState == ConnectionState.waiting) return const Text("Loading");
          if (snapshot.data == null) return const Text('Document does not exist');
          final data = snapshot.data!.data()! as Map<String, dynamic>;
          final messages = data['messages'] as List<dynamic> ?? [];

          return Column(
            children: [
              // mesajların duzgunce listelendigi kısım
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: messages.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       final message = messages[index] as Map<String, dynamic>;
              //       return ListTile(
              //         title: Text(
              //           message['namesurname'] as String,
              //           textAlign: TextAlign.end,
              //         ),
              //         subtitle: Container(
              //           color: Colors.grey[200],
              //           child: Text(
              //             message['message'] as String,
              //             textAlign: TextAlign.end,
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
              // mesajları listeleyemedigim kısım

              Expanded(
                child: GroupedListView(
                  floatingHeader: true,
                  useStickyGroupSeparators: true,
                  //reverse: true,
                  elements: messages,
                  groupBy: (element) {
                    messages.sort((a, b) => (a['timestamp'] as Timestamp).compareTo(b['timestamp'] as Timestamp));
                    // Group messages by date
                    DateTime timestamp = (element['timestamp'] as Timestamp).toDate();
                    return DateTime(timestamp.year, timestamp.month, timestamp.day);
                  },
                  groupHeaderBuilder: (dynamic message) => SizedBox(
                    height: 50,
                    child: Center(
                      child: Card(
                        color: primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            DateFormat.yMMMd().format(
                              (message['timestamp'] as Timestamp).toDate().toLocal(),
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  itemBuilder: (context, dynamic message) => Align(
                    alignment: message['uid'] == uid ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(right: 8, top: 10, left: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: message['uid'] == uid ? Colors.blue : Colors.grey[200],
                      ),
                      child: Text(message['message'] as String, style: TextStyle(color: message['uid'] == uid ? Colors.white : Colors.black, fontSize: 16)),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: buttonColor2, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Mesaj',
                          contentPadding: EdgeInsets.all(10),
                          border: InputBorder.none,
                        ),
                        controller: _messageViewModel.sendMessageController,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: buttonColor2,
                      ),
                      child: IconButton(
                        onPressed: sendMessage,
                        icon: const Icon(Icons.send),
                        color: primaryColor,
                      ),
                    ),
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
