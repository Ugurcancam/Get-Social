part of 'select_profile_picture_view.dart';

mixin SelectProfilePictureViewMixin on State<SelectProfilePictureView> {
  String? filePath;

  //Services
  final FileManager _fileManager = FileManager();

  //Update the file path after select the photo
  void _updateFilePath(String? fileePath) {
    setState(() {
      filePath = fileePath;
    });
  }

  // Navigate to the display profile picture page
  void navigateToDisplayProfilePicture() {
    Navigator.push(
      context,
      MaterialPageRoute<DisplaySelectedImageView>(
        builder: (context) => DisplaySelectedImageView(filePath: filePath!),
      ),
    );
  }

  // Open the animated dialog for select the way of photo
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
                      await _fileManager.photoShot(_updateFilePath, navigateToDisplayProfilePicture);
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
                      await _fileManager.pickFile(_updateFilePath, navigateToDisplayProfilePicture);
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
