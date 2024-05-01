import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlikapp/features/event_room/domain/models/event_rooms_model.dart';

class EventRoomService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<EventRoomModel>> getEventRooms() async {
    final snapshot = await _firestore.collection('event_rooms').get();
    final eventRoomData = snapshot.docs.map((doc) => EventRoomModel.fromSnapshot(doc, doc.id)).toList();
    return eventRoomData;
  }

  //Get events by category
  Future<List<EventRoomModel>> getEventRoomsByCategory({required String category}) async {
    final snapshot = await _firestore.collection('event_rooms').where('category', isEqualTo: category).get();
    if (snapshot.docs.isEmpty) {
      print('Belirtilen kategoride etkinlik bulunamadı.');
    }
    if (snapshot.docs.isNotEmpty) {
      print(snapshot.docs.length.toString() + ' adet etkinlik bulundu.');
    }
    final eventRoomData = snapshot.docs.map((doc) => EventRoomModel.fromSnapshot(doc, doc.id)).toList();
    return eventRoomData;
  }

  //Get events by province
  Future<List<EventRoomModel>> getEventRoomsByProvince({required String province}) async {
    final snapshot = await _firestore.collection('event_rooms').where('province', isEqualTo: province).get();
    if (snapshot.docs.isEmpty) {
      print('Belirtilen ilde etkinlik bulunamadı.');
    }
    if (snapshot.docs.isNotEmpty) {
      print(snapshot.docs.length.toString() + ' adet etkinlik bulundu.');
    }
    final eventRoomData = snapshot.docs.map((doc) => EventRoomModel.fromSnapshot(doc, doc.id)).toList();
    return eventRoomData;
  }

  Future<void> createRoom({required String eventName, required String eventDetail, required String eventDate, required String category, required String eventTime, required String creatorUid, required String namesurname, required String coordinate, required String province, required String district, required String addressDetail}) async {
    // Kategorileri isimlerle eşleştirilmiş bir harita oluştur
    // List<Map<String, String>> categoryList = category.map((categoryName) => {'name': categoryName}).toList();

    final eventData = {
      'eventName': eventName,
      'eventDetail': eventDetail,
      'eventDate': eventDate,
      'eventTime': eventTime,
      'creatorUid': creatorUid,
      'messages': [],
      'approved_users': [
        {'uid': creatorUid, 'namesurname': namesurname},
      ],
      'pending_approval_users': [],
      'category': category,
      'coordinate': coordinate,
      'province': province,
      'district': district,
      'address_detail': addressDetail,
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

  Future<void> sendMessage({required String docId, required String uid, required String namesurname, required String message}) async {
    // Create a reference to the event room document
    final docRef = _firestore.collection('event_rooms').doc(docId);
    // Perform a transaction to ensure data consistency
    await _firestore.runTransaction((transaction) async {
      // Get the current document snapshot
      final snapshot = await transaction.get(docRef);

      // Extract the existing messages list (if it exists)
      final existingMessages = snapshot.get('messages') as List<dynamic>?;

      // Create a new list to hold the updated messages
      final updatedMessages = (existingMessages ?? []).toList();
      // Add the new message to the list
      updatedMessages.add({
        'uid': uid,
        'namesurname': namesurname,
        'message': message,
        'timestamp': Timestamp.now(),
      });

      // Update the document with the modified list
      transaction.update(docRef, {'messages': updatedMessages});
    });
  }

  // Get the stream messages for a specific event room
  Stream<DocumentSnapshot> getMessagesStream({required String docId}) {
    return _firestore.collection('event_rooms').doc(docId).snapshots();
  }
}
