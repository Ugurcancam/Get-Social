// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'namesurname': namesurname,
      'uid': uid,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> map) {
    return UserModel(
      email: map['email'] as String,
      namesurname: map['namesurname'] as String,
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromSnapshot(json.decode(source) as DocumentSnapshot<Map<String, dynamic>>);

  // factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json) {
  //   return UserModel(
  //     email: json['email'],
  //     namesurname: json['namesurname'],
  //     uid: json['uid'],
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'email': email,
  //     'namesurname': namesurname,
  //     'uid': uid,
  //   };
  // }
}
