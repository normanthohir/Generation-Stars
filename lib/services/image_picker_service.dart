// import 'dart:io';
// import 'package:image_picker/image_picker.dart';

// class ImagePickerService {
//   static Future<File?> pickImage(ImageSource source) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: source);
//     return pickedFile != null ? File(pickedFile.path) : null;
//   }
// }
// lib/services/image_picker_service.dart
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static Future<File?> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      maxWidth: 600,
      maxHeight: 600,
      imageQuality: 85,
    );

    if (pickedFile == null || pickedFile.path.isEmpty) {
      print("⚠️ Tidak ada file yang dipilih.");
      return null;
    }

    return File(pickedFile.path);
  }
}
