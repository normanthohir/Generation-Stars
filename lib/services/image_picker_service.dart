import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static Future<File?> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    return pickedFile != null ? File(pickedFile.path) : null;
  }
}
