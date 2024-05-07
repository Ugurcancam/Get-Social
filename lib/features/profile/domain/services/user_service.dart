import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlikapp/features/auth/domain/models/user_model.dart';
import 'package:etkinlikapp/features/event_room/domain/models/event_rooms_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _filePath;
  String? _downloadURL;

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

  Future<void> pickFile(void Function(String?) onFilePicked) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        _filePath = result.files.single.path;
        onFilePicked(_filePath);
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  Future<void> uploadFile(void Function(String?) onUploadComplete) async {
    if (_filePath != null) {
      try {
        File file = File(_filePath!);
        String fileName = '${DateTime.now().millisecondsSinceEpoch}-${file.path.split('/').last}';
        final ref = FirebaseStorage.instance.ref().child('files/$fileName');
        await ref.putFile(file);
        _downloadURL = await ref.getDownloadURL();
        print(_downloadURL);

        // Update profile photo for current user
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
            'profilePhotoURL': _downloadURL,
          });
        }

        onUploadComplete(_downloadURL);
        _filePath = null;
      } catch (e) {
        print('Error uploading file: $e');
      }
    } else {
      print('No file selected');
    }
  }
  // //Get logged in users information
  // Future<UserModel?> getLoggedInUserDetails(String uid) async {
  //   final snapshot = await _firestore.collection('users').doc(uid).get();
  //   if (snapshot.exists) {
  //     final userData = UserModel.fromSnapshot(snapshot);
  //     return userData;
  //   } else {
  //     return null;
  //   }
  // }
}
