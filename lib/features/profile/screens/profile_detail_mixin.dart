part of 'profile_detail_view.dart';

mixin ProfileDetailMixin on State<ProfileDetail> {
  //Get logged in user's email
  final email = FirebaseAuth.instance.currentUser!.email;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  final FileManager _fileManager = FileManager();

  String? _filePath;
  String? _downloadURL;

  void _onFilePicked(String? filePathh) {
    setState(() {
      _fileManager.filePath = filePathh;
    });
  }

  Future<void> _pickFile() async {
    await _fileManager.pickFile(_onFilePicked);
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
