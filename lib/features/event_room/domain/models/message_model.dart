import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
final class Message {
  final String uid;
  final String message;
  final String namesurname;
  final String? docId;
  final Timestamp timestamp;

  const Message({
    required this.docId,
    required this.uid,
    required this.message,
    required this.namesurname,
    required this.timestamp,
  });

  factory Message.fromSnapshot(QueryDocumentSnapshot snapshot, String docId) {
    return Message(
      uid: snapshot['uid'] as String,
      message: snapshot['message'] as String,
      namesurname: snapshot['namesurname'] as String,
      timestamp: snapshot['timestamp'] as Timestamp,
      docId: docId,
    );
  }
}
