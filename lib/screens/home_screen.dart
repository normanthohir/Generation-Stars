import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generation_stars/utils/colors.dart';
import 'package:generation_stars/widgets/image_source_modal.dart';
import 'package:generation_stars/widgets/shared_appbar.dart';
import 'package:generation_stars/widgets/widgets_nutrisi_mingguna.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../services/image_picker_service.dart';
import '../services/tflite_service.dart';
import '../services/nutrition_service.dart';
import 'result_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;
  String? _result;
  Map<String, dynamic>? _nutrisi;

  @override
  void initState() {
    super.initState();
    TFLiteService.loadModel();
  }

  Future<void> _processImage(ImageSource source) async {
    final image =
        await ImagePickerService.pickImage(source); // Pass source here
    if (image == null) return;

    setState(() => _image = image);

    final result = await TFLiteService.classifyImage(image);
    if (result != null) {
      final label = result['label'];
      final nutrisi = await NutritionService.loadNutrisi(label);

      setState(() {
        _result = label;
        _nutrisi = nutrisi;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            image: _image!,
            label: _result!,
            nutrisi: _nutrisi,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: SharedAppbar(
        title: "Haii Nama Penguna👋",
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                child: WidgetsNutrisiMingguan(),
              ),
              SizedBox(height: 50),
              Text(
                'Deteksi Nutrisi Makanan',
                style: GoogleFonts.poppins(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Pilih sumber gambar untuk memeriksa\nnutrisi makanan bagi ibu hamil',
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.poppins(fontSize: 15, color: AppColors.subtext),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      backgroundColor: AppColors.background,
                      builder: (context) => ImageSourceModal(
                        onCameraSelected: () =>
                            _processImage(ImageSource.camera),
                        onGallerySelected: () =>
                            _processImage(ImageSource.gallery),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.button,
                      foregroundColor: Color(0xFFF1EFEC),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.cameraRetro,
                          size: 28,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Pilih gambar',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
