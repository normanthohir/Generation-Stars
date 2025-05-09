import 'package:tflite/tflite.dart';
import 'dart:io';

class TFLiteService {
  // memuat model TensorFlow Lite ke dalam memori
  static Future<void> loadModel() async {
    await Tflite.loadModel(
      model: "assets/models/food_model.tflite",
      labels: "assets/models/labels.txt",
    );
  }

// mengklasifikasikan gambar menggunakan model yang sudah dimuat
  static Future<Map<String, dynamic>?> classifyImage(File image) async {
    // Future<Map<String, dynamic>?> menandakan fungsi ini mengembalikan Map yang berisi string dan nilai dinamis, atau null jika klasifikasi gagal
    final output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 5,
      threshold: 0.8,
      imageMean: 0.0,
      imageStd: 255.0,
    );

    if (output != null && output.isNotEmpty) {
      final label = output[0]['label']
          .toString()
          .toLowerCase()
          .replaceAll(RegExp(r'^\d+\s*'), '')
          .trim();
      final confidence = output[0]['confidence'];
      return {
        'label': label,
        'confidence': confidence,
      };
    }
    return null;
  }
}
