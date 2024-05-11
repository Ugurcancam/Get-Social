import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codegen/gen/colors.gen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import 'profile_detail_view.dart';

class ImageDisplayPage extends StatefulWidget {
  final String filePath;

  const ImageDisplayPage({required this.filePath});

  @override
  State<ImageDisplayPage> createState() => _ImageDisplayPageState();
}

class _ImageDisplayPageState extends State<ImageDisplayPage> {
  late String _downloadURL;
  File? _croppedFile;

  Future<void> _uploadFile() async {
    final file = _croppedFile ?? File(widget.filePath);
    try {
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
    } catch (e) {
      // Handle file upload error
      print('Error uploading file: $e');
    }
  }

  Future<void> _cropImage(String filePath) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Fotoğrafı Kırp',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Fotoğrafı Kırp',
        )
      ],
    );
    if (croppedFile != null) {
      setState(() {
        _croppedFile = File(croppedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _cropImage(widget.filePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: _croppedFile != null
                ? Image.file(
                    _croppedFile!,
                    width: double.infinity, // Adjust width as needed
                    height: 300, // Adjust height as needed
                  )
                : Image.file(
                    File(widget.filePath),
                    width: double.infinity, // Adjust width as needed
                    height: 300, // Adjust height as needed
                  ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/homepage');
                  },
                  child: const Text('Vazgeç', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorName.primary,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    await _uploadFile();
                    await Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileDetail()),
                    );
                  },
                  child: const Text('Kaydet', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorName.primary,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
