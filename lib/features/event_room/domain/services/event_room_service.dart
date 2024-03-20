import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlikapp/features/event_room/domain/models/event_rooms_model.dart';

class EventRoomService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<EventRoomModel>> getEventRooms() async {
    final snapshot = await _firestore.collection("event_rooms").get();
    final eventRoomData = snapshot.docs.map((doc) => EventRoomModel.fromSnapshot(doc, doc.id)).toList();
    return eventRoomData;
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>> getEventRoomsStream() {
    final stream = _firestore.collection('event_rooms').snapshots().listen(
      (event) {
        event.docs.forEach((element) {
          print(element.data());
        });
      },
    );

    return stream;
  }

  Future<void> createRoom({required String eventName, required String eventDate, required String creatorUid, required String namesurname, required List<String> category}) async {
    // Kategorileri isimlerle eşleştirilmiş bir harita oluştur
    List<Map<String, String>> categoryList = category.map((categoryName) => {'name': categoryName}).toList();

    final eventData = {
      'eventName': eventName,
      'eventDate': eventDate,
      'creatorUid': creatorUid,
      'approved_users': [
        {'uid': creatorUid, 'namesurname': namesurname},
      ],
      'pending_approval_users': [
        {
          'uid': "",
          'namesurname': "",
        },
      ],
      'category': categoryList,
    };
    await _firestore.collection('event_rooms').add(eventData);
  }

  //Burada ileride uid listede varmı diye bakarak kullanıcı istek atıp atmadığı kontrol edilebilir.
  Future<void> addPendingUser({required String docId, required String uid, required String namesurname}) async {
    // Create a reference to the event room document
    final docRef = _firestore.collection('event_rooms').doc(docId);

    // Perform a transaction to ensure data consistency
    await _firestore.runTransaction((transaction) async {
      // Get the current document snapshot
      final snapshot = await transaction.get(docRef);

      // Extract the existing pending_approval_users list (if it exists)
      final existingUsers = snapshot.get('pending_approval_users') as List<dynamic>?;

      // Create a new list to hold the updated users
      final updatedUsers = (existingUsers ?? []).toList();
      // Add the new user to the list
      updatedUsers.add({
        'uid': uid,
        'namesurname': namesurname,
      });

      // Update the document with the modified list
      transaction.update(docRef, {'pending_approval_users': updatedUsers});
    });
  }

  Future<void> approveUser({required String docId, required String uid, required String namesurname}) async {
    // Create a reference to the event room document
    final docRef = _firestore.collection('event_rooms').doc(docId);
    // Perform a transaction to ensure data consistency
    await _firestore.runTransaction((transaction) async {
      // Get the current document snapshot
      final snapshot = await transaction.get(docRef);

      //Delete the user from pending_approval_users list
      final pendingUsers = snapshot.get('pending_approval_users') as List<dynamic>?;
      transaction.update(docRef, {'pending_approval_users': pendingUsers?..removeWhere((user) => user['uid'] == uid)});

      // Extract the existing approved_users list (if it exists)
      final existingUsers = snapshot.get('approved_users') as List<dynamic>?;

      // Create a new list to hold the updated users
      final updatedUsers = (existingUsers ?? []).toList();
      // Add the new user to the list
      updatedUsers.add({
        'uid': uid,
        'namesurname': namesurname,
      });

      // Update the document with the modified list
      transaction.update(docRef, {'approved_users': updatedUsers});
    });
  }

  Future<void> denyApproval({required String docId, required String uid}) async {
    // Create a reference to the event room document
    final docRef = _firestore.collection('event_rooms').doc(docId);
    // Perform a transaction to ensure data consistency
    await _firestore.runTransaction((transaction) async {
      // Get the current document snapshot
      final snapshot = await transaction.get(docRef);

      //Delete the user from pending_approval_users list
      final pendingUsers = snapshot.get('pending_approval_users') as List<dynamic>?;
      transaction.update(docRef, {'pending_approval_users': pendingUsers?..removeWhere((user) => user['uid'] == uid)});
    });
  }
}
