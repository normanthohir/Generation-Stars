import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generation_stars/screens/edukasi_screen.dart';
import 'package:generation_stars/screens/tentang_aplikasi_screen.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:generation_stars/widgets/widget_custom_appBar_menu.dart';
import 'package:generation_stars/widgets/widget_image_source_modal.dart';
import 'package:generation_stars/shared/shared_appbar.dart';
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
      backgroundColor: ColorsApp.white,
      appBar: SharedAppbar(
        title: "Haii Nama Penguna👋",
        actions: [
          CustomAppBarMenu(
            iconItemColor: ColorsApp.hijauTua,
            textColor: ColorsApp.hijauTua,
            menuColor: ColorsApp.white,
            items: [
              AppBarMenuItem(
                value: 'tentang',
                label: 'Tentang',
                icon: FontAwesomeIcons.circleInfo,
                onSelected: (context) => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TentangAplikasiScreen())),
              ),
              AppBarMenuItem(
                value: 'edukasi',
                label: 'Edukasi',
                icon: FontAwesomeIcons.book,
                onSelected: (context) => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EdukasiScreen())),
              ),
              AppBarMenuItem(
                value: 'keluar',
                label: 'Keluar',
                icon: FontAwesomeIcons.rightFromBracket,
                onSelected: (context) => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Keluar Aplikasi'),
                    content: Text('Apakah Anda yakin ingin keluar?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () => exit(0),
                        child: Text('Keluar'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            iconColor: ColorsApp.black,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: WidgetsNutrisiMingguan(),
              ),
              SizedBox(height: 50),
              Text(
                'Deteksi Nutrisi Makanan',
                style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: ColorsApp.text),
              ),
              SizedBox(height: 10),
              Text(
                'Pilih sumber gambar untuk memeriksa\nnutrisi makanan bagi ibu hamil',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 15, color: ColorsApp.grey),
              ),
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      backgroundColor: Colors.white,
                      builder: (context) => ImageSourceModal(
                        onCameraSelected: () =>
                            _processImage(ImageSource.camera),
                        onGallerySelected: () =>
                            _processImage(ImageSource.gallery),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsApp.hijau,
                      foregroundColor: ColorsApp.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.cameraRetro,
                          size: 24,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Pilih gambar',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
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
