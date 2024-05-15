part of 'display_selected_image_view.dart';

mixin DisplaySelectedImageMixin on State<DisplaySelectedImageView> {
  late String _downloadURL;
  File? _croppedFile;
  bool _isLoading = false;

  // Upload the file to Firebase Storage and update the profile photo URL
  Future<void> _uploadFile() async {
    final file = _croppedFile ?? File(widget.filePath);
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}-${file.path.split('/').last}';
      final ref = FirebaseStorage.instance.ref().child('files/$fileName');
      await ref.putFile(file);
      _downloadURL = await ref.getDownloadURL();

      // Update profile photo for current user
      final user = FirebaseAuth.instance.currentUser;
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

  // Crop the selected image
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
}
