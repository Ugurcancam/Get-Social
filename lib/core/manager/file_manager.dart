import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class FileManager {
  //Pick a file from the device
  Future<void> pickFile(void Function(String?) onFileSelect, void Function() navigate) async {
    try {
      final result = await FilePicker.platform.pickFiles();

      if (result != null) {
        onFileSelect(result.files.single.path);
      }
      //For navigate the next page after select the photo
      navigate();
    } catch (e) {
      // Handle file picking error
      print('Error picking file: $e');
    }
  }

  // Take a photo from the camera
  Future<void> photoShot(void Function(String?) onPhotoshot, void Function() navigate) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      onPhotoshot(pickedFile.path);
    }
    //For navigate the next page after select the photo
    navigate();
  }
}
