import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String namesurname;
  final String uid;

  UserModel({
    required this.email,
    required this.namesurname,
    required this.uid,
  });

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json) {
    return UserModel(
      email: json['email'],
      namesurname: json['namesurname'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'namesurname': namesurname,
      'uid': uid,
    };
  }
}
