import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PickFileView extends StatefulWidget {
  @override
  _PickFileViewState createState() => _PickFileViewState();
}

class _PickFileViewState extends State<PickFileView> {
  String? _filePath;
  String? _downloadURL;

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          _filePath = result.files.single.path;
        });
      }
    } catch (e) {
      // Handle file picking error
      print('Error picking file: $e');
    }
  }

  Future<void> _uploadFile() async {
    if (_filePath != null) {
      try {
        File file = File(_filePath!);
        String fileName = '${DateTime.now().millisecondsSinceEpoch}-${file.path.split('/').last}';
        final ref = FirebaseStorage.instance.ref().child('files/$fileName');
        await ref.putFile(file);
        _downloadURL = await ref.getDownloadURL();
        print(_downloadURL);

        // Update profile photo for current user
        // User? user = FirebaseAuth.instance.currentUser;
        // if (user != null) {
        //   await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        //     'profilePhotoURL': _downloadURL,
        //   });
        // }

        setState(() {
          _filePath = null;
        });
      } catch (e) {
        // Handle file upload error
        print('Error uploading file: $e');
      }
    } else {
      print('No file selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickFile,
              child: Text('Pick File'),
            ),
            SizedBox(height: 16),
            Image.network(
              'https://firebasestorage.googleapis.com/v0/b/etkinlikapp-4fb16.appspot.com/o/files%2F1711053690017-download.png?alt=media&token=e5aafb55-f089-49b1-8a05-f49e82708a26',
              height: 200,
              width: 200,
            ),
            Container(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _uploadFile,
              child: Text('Upload File'),
            ),
          ],
        ),
      ),
    );
  }
}
