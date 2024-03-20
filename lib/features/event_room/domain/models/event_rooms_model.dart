import 'package:cloud_firestore/cloud_firestore.dart';

class EventRoomModel {
  final String eventName;
  final String eventDate;
  final String creatorUid;
  final String? docId;
  final List<AppRovedUsers> approvedUsers;
  final List<PendingApprovalUsers> pendingApprovalUsers;
  final List<EventCategories> categories;

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
      eventName: snapshot['eventName'],
      eventDate: snapshot['eventDate'],
      creatorUid: snapshot['creatorUid'],
      approvedUsers: (snapshot['approved_users'] as List).map((e) => AppRovedUsers.fromMap(e)).toList(),
      pendingApprovalUsers: (snapshot['pending_approval_users'] as List).map((e) => PendingApprovalUsers.fromMap(e)).toList(),
      categories: (snapshot['category'] as List).map((e) => EventCategories.fromMap(e)).toList(),
      docId: docId,
    );
  }
}

class AppRovedUsers {
  final String uid;
  final String namesurname;

  AppRovedUsers({
    required this.uid,
    required this.namesurname,
  });

  factory AppRovedUsers.fromMap(Map<String, dynamic> data) {
    return AppRovedUsers(
      uid: data['uid'],
      namesurname: data['namesurname'],
    );
  }
}

class PendingApprovalUsers {
  final String uid;
  final String namesurname;

  PendingApprovalUsers({
    required this.uid,
    required this.namesurname,
  });

  factory PendingApprovalUsers.fromMap(Map<String, dynamic> data) {
    return PendingApprovalUsers(
      uid: data['uid'],
      namesurname: data['namesurname'],
    );
  }
}

class EventCategories {
  final String name;

  EventCategories({
    required this.name,
  });

  factory EventCategories.fromMap(Map<String, dynamic> data) {
    return EventCategories(
      name: data['name'],
    );
  }
}
