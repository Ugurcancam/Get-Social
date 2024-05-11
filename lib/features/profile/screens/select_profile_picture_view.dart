import 'package:codegen/codegen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:etkinlikapp/features/profile/screens/display_selected_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelectProfilePictureView extends StatefulWidget {
  const SelectProfilePictureView({super.key});

  @override
  State<SelectProfilePictureView> createState() => _SelectProfilePictureViewState();
}

class _SelectProfilePictureViewState extends State<SelectProfilePictureView> {
  final ImagePicker _picker = ImagePicker();
  String? _filePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 18.0,
          top: 10,
          right: 18.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Profil Fotoğrafı Seç', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
            const SizedBox(height: 20),
            Text('Çok sevdiğin bir selfien var mı? Hemen yükle.', style: TextStyle(fontSize: 15, color: Colors.grey)),
            const SizedBox(height: 80),
            InkWell(
              onTap: () => openAnimatedDialog(context),
              child: Center(
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  color: ColorName.primary,
                  strokeWidth: 2,
                  dashPattern: [16, 10],
                  radius: Radius.circular(10),
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.camera, size: 90, color: ColorName.primary),
                        const SizedBox(height: 15),
                        Text('Yükle', style: TextStyle(fontSize: 20, color: ColorName.primary, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          _filePath = result.files.single.path;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageDisplayPage(filePath: _filePath!),
          ),
        );
      }
    } catch (e) {
      // Handle file picking error
      print('Error picking file: $e');
    }
  }

  Future<void> _takePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _filePath = pickedFile.path;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageDisplayPage(filePath: _filePath!),
        ),
      );
    }
  }

  void openAnimatedDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Container();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0, end: 1).animate(animation),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(animation),
            child: AlertDialog(
              backgroundColor: Colors.white,
              //title: Text('Profil Fotoğrafı Seç'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
                children: [
                  TextButton(
                    onPressed: () async {
                      await _takePhoto();
                    },
                    child: Text(
                      'Fotoğraf çek',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await _pickFile();
                    },
                    child: Text(
                      'Mevcut fotoğraflardan seç',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
