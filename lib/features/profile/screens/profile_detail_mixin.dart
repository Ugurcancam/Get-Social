part of 'profile_detail_view.dart';

mixin ProfileDetailMixin on State<ProfileDetail> {
  //Get logged in user's email
  final email = FirebaseAuth.instance.currentUser!.email;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  String? _filePath;
  String? _downloadURL;

  void navigateToSelectPP() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectProfilePictureView(),
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
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
            'profilePhotoURL': _downloadURL,
          });
        }

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
}
