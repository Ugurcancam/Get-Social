import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlikapp/features/auth/domain/models/user_model.dart';
import 'package:etkinlikapp/features/event_room/domain/models/event_rooms_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> getUserDetails(String email) async {
    final snapshot = await _firestore.collection('users').where('email', isEqualTo: email).get();
    // if (snapshot.docs.isNotEmpty) {
    //   final userData = UserModel.fromSnapshot(snapshot.docs.first);
    //   return userData;
    // } else {
    //   return null;
    // }
    if (snapshot.docs.isEmpty) return null;
    return UserModel.fromSnapshot(snapshot.docs.first);
  }

  Future<List<EventRoomModel>?> getUsersEventRooms(String creatorUid) async {
    final snapshot = await _firestore.collection('event_rooms').where('creatorUid', isEqualTo: creatorUid).get();
    if (snapshot.docs.isNotEmpty) {
      final userData = snapshot.docs.toList().map((e) => EventRoomModel.fromSnapshot(e, e.id)).toList();
      return userData;
    } else {
      return null;
    }
  }
}
