import 'package:cloud_firestore/cloud_firestore.dart';

final class EventRoomModel {
  EventRoomModel({
    required this.eventName,
    required this.eventDate,
    required this.creatorUid,
    required this.approvedUsers,
    required this.pendingApprovalUsers,
    required this.docId,
    required this.categories,
  });

  factory EventRoomModel.fromSnapshot(DocumentSnapshot snapshot, String docId) {
    return EventRoomModel(
      eventName: snapshot['eventName'] as String,
      eventDate: snapshot['eventDate'] as String,
      creatorUid: snapshot['creatorUid'] as String,
      approvedUsers: (snapshot['approved_users'] as List).map((e) => AppRovedUsers.fromMap(e as Map<String, dynamic>)).toList(),
      pendingApprovalUsers: (snapshot['pending_approval_users'] as List<dynamic>).map((e) => PendingApprovalUsers.fromMap(e as Map<String, dynamic>)).toList(),
      categories: (snapshot['category'] as List<dynamic>).map((e) => EventCategories.fromMap(e as Map<String, dynamic>)).toList(),
      docId: docId,
    );
  }
  final String eventName;
  final String eventDate;
  final String creatorUid;
  final String? docId;
  final List<AppRovedUsers> approvedUsers;
  final List<PendingApprovalUsers> pendingApprovalUsers;
  final List<EventCategories> categories;
}

class AppRovedUsers {
  AppRovedUsers({
    required this.uid,
    required this.namesurname,
  });

  factory AppRovedUsers.fromMap(Map<String, dynamic> data) {
    return AppRovedUsers(
      uid: data['uid'] as String,
      namesurname: data['namesurname'] as String,
    );
  }
  final String uid;
  final String namesurname;
}

class PendingApprovalUsers {
  PendingApprovalUsers({
    required this.uid,
    required this.namesurname,
  });

  factory PendingApprovalUsers.fromMap(Map<String, dynamic> data) {
    return PendingApprovalUsers(
      uid: data['uid'] as String,
      namesurname: data['namesurname'] as String,
    );
  }
  final String uid;
  final String namesurname;
}

class EventCategories {
  EventCategories({
    required this.name,
  });

  factory EventCategories.fromMap(Map<String, dynamic> data) {
    return EventCategories(
      name: data['name'] as String,
    );
  }
  final String name;
}
