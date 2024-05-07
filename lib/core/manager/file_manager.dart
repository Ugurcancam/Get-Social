import 'package:file_picker/file_picker.dart';

class FileManager {
  String? filePath;

  // For file picking from device
  Future<void> pickFile(
    void Function(String?) onFilePicked,
  ) async {
    try {
      final result = await FilePicker.platform.pickFiles();

      if (result != null) {
        filePath = result.files.single.path;
        onFilePicked(filePath);
        print(filePath);
      }
    } catch (e) {
      // Handle file picking error
      print('Error picking file: $e');
    }
  }
}
