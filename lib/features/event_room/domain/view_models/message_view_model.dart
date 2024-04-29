import 'package:etkinlikapp/features/event_room/domain/services/event_room_service.dart';
import 'package:flutter/material.dart';

class MessageViewModel {
  final _eventRoomService = EventRoomService();
  final sendMessageController = TextEditingController();

  Future<void> sendMessage(String docId, String uid, String nameSurname) async {
    if (sendMessageController.text.isNotEmpty) {
      await _eventRoomService.sendMessage(docId: docId, uid: uid, namesurname: nameSurname, message: sendMessageController.text);
      sendMessageController.clear();
    }
  }
}
