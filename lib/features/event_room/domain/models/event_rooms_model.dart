import 'package:cloud_firestore/cloud_firestore.dart';

final class EventRoomModel {
  final String eventName;
  final String eventDate;
  final String eventDetail;
  final String eventTime;
  final String creatorUid;
  final String addressDetail;
  final String coordinate;
  final String district;
  final String province;
  final String? docId;
  final List<AppRovedUsers> approvedUsers;
  final List<PendingApprovalUsers> pendingApprovalUsers;
  final String categories;

  EventRoomModel({
    required this.eventName,
    required this.eventDate,
    required this.eventTime,
    required this.eventDetail,
    required this.creatorUid,
    required this.approvedUsers,
    required this.pendingApprovalUsers,
    required this.docId,
    required this.categories,
    required this.addressDetail,
    required this.coordinate,
    required this.district,
    required this.province,
  });

  factory EventRoomModel.fromSnapshot(DocumentSnapshot snapshot, String docId) {
    return EventRoomModel(
      eventName: snapshot['eventName'] as String,
      eventDate: snapshot['eventDate'] as String,
      eventTime: snapshot['eventTime'] as String,
      eventDetail: snapshot['eventDetail'] as String,
      addressDetail: snapshot['address_detail'] as String,
      coordinate: snapshot['coordinate'] as String,
      district: snapshot['district'] as String,
      province: snapshot['province'] as String,
      creatorUid: snapshot['creatorUid'] as String,
      approvedUsers: (snapshot['approved_users'] as List).map((e) => AppRovedUsers.fromMap(e as Map<String, dynamic>)).toList(),
      pendingApprovalUsers: (snapshot['pending_approval_users'] as List<dynamic>).map((e) => PendingApprovalUsers.fromMap(e as Map<String, dynamic>)).toList(),
      categories: (snapshot['category'] as String),
      docId: docId,
    );
  }

  static fromMap(event) {}
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
