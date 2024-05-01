// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  final String email;
  final String namesurname;
  final String province;
  final String uid;
  final String? profilePhotoURL;

  const UserModel({
    required this.email,
    required this.namesurname,
    required this.province,
    required this.uid,
    this.profilePhotoURL = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'namesurname': namesurname,
      'province': province,
      'uid': uid,
      'profilePhotoURL': profilePhotoURL,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> map) {
    return UserModel(
      email: map['email'] as String,
      namesurname: map['namesurname'] as String,
      province: map['province'] as String,
      uid: map['uid'] as String,
      profilePhotoURL: map['profilePhotoURL'] as String,
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
