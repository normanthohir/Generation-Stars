import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generation_stars/screens/edukasi_screen.dart';
import 'package:generation_stars/screens/tentang_aplikasi_screen.dart';
import 'package:generation_stars/services/profile_service.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:generation_stars/widgets/widget_custom_appBar_menu.dart';
import 'package:generation_stars/widgets/widget_dialog_loading.dart';
import 'package:generation_stars/widgets/widget_image_source_modal.dart';
import 'package:generation_stars/shared/shared_appbar.dart';
import 'package:generation_stars/widgets/widgets_nutrisi_mingguna.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
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

  // Map<String, dynamic>? _userData;
  Map<String, dynamic>? _profileData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    TFLiteService.loadModel();
    _loadUserData();
  }

  // function untuk menampilkan data informasi profile
  Future<void> _loadUserData() async {
    final profile = await UserService.getCurrentUserProfile();
    setState(() {
      _profileData = profile;
      _isLoading = false;
    });
  }

  // function  untuk memprosess gambar untuk ddeteksi nutrisi
  // atau mencocokan jenismakan dari model Tflite CNN dengan dara nutrisi makanan di file CSV dengan label
  // Future<void> _processImage(ImageSource source) async {
  //   final image = await ImagePickerService.pickImage(source);
  //   if (image == null) return;

  //   setState(() => _image = image);

  //   final result = await TFLiteService.classifyImage(image);
  //   if (result != null) {
  //     final label = result['label'];
  //     final nutrisi = await NutritionService.loadNutrisi(label);

  //     setState(() {
  //       _result = label;
  //       _nutrisi = nutrisi;
  //     });

  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => ResultScreen(
  //           image: _image!,
  //           label: _result!,
  //           nutrisi: _nutrisi,
  //         ),
  //       ),
  //     );
  //   }
  // }
  Future<void> _processImage(ImageSource source) async {
    print("🔍 Memilih gambar...");
    final image = await ImagePickerService.pickImage(source);
    if (image == null) {
      print("⚠️ Tidak ada gambar.");
      return;
    }

    setState(() => _image = image);
    print("Gambar berhasil dipilih: ${image.path}");

    showLoadingDialog(context);

    print("Mengklasifikasi gambar...");
    final result = await TFLiteService.classifyImage(image);

    hideLoadingDialog(context);

    if (result != null) {
      final label = result['label'];
      print("✅ Label hasil klasifikasi: $label");

      final nutrisi = await NutritionService.loadNutrisi(label);
      setState(() {
        _result = label;
        _nutrisi = nutrisi;
      });

      print("➡️ Navigasi ke ResultScreen...");
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
    } else {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(message: "Gagal klasifikasi gambar."),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.white,
      appBar: SharedAppbar(
        title: _isLoading
            ? 'Haii'
            : 'Haii, ${_profileData?['nama'] ?? 'Pengguna'}👋',
        actions: [
          // Costum appbar menu
          _appBarMenu(),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  children: [
                    Text(
                      'Progres Mingguan',
                      style: GoogleFonts.poppins(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    _isLoading
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [
                                const SizedBox(height: 4),
                                Container(
                                  height: 11,
                                  width: 160,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Text(
                            'Kehamilan minggu ke ${_hitungKehamilanPerminggu()}',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: ColorsApp.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                    WidgetsNutrisiMingguan()
                  ],
                ),
              ),
              SizedBox(height: 15),
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
              SizedBox(height: 25),
              // button untuk memilih sumber gambar
              _buttonPilihGambar()
            ],
          ),
        ),
      ),
    );
  }

// Widget costum appbar menu
  Widget _appBarMenu() {
    return CustomAppBarMenu(
      iconItemColor: ColorsApp.hijauTua,
      textColor: ColorsApp.hijauTua,
      menuColor: ColorsApp.white,
      items: [
        AppBarMenuItem(
          value: 'tentang',
          label: 'Tentang',
          icon: FontAwesomeIcons.circleInfo,
          onSelected: (context) => Navigator.push(context,
              MaterialPageRoute(builder: (context) => TentangAplikasiScreen())),
        ),
        AppBarMenuItem(
          value: 'edukasi',
          label: 'Edukasi',
          icon: FontAwesomeIcons.book,
          onSelected: (context) => Navigator.push(context,
              MaterialPageRoute(builder: (context) => EdukasiScreen())),
        ),
      ],
      iconColor: ColorsApp.black,
    );
  }

// Widget  untuk memilih sumber gambar
  Widget _buttonPilihGambar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            backgroundColor: Colors.white,
            builder: (context) => ImageSourceModal(
              onCameraSelected: () => _processImage(ImageSource.camera),
              onGallerySelected: () => _processImage(ImageSource.gallery),
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
    );
  }

  // menghitung usia kehamilan perminggu
  String _hitungKehamilanPerminggu() {
    // mengambil tanggal kehamilan dari data profile
    final mulaiTgl = DateTime.parse(_profileData!['tanggal_kehamilan']);
    // menghitung selisih hari antara tanggal sekarang dan tanggal kehamilan
    final mingguKe = DateTime.now().difference(mulaiTgl).inDays ~/ 7;
    return mingguKe.toString();
  }
}
// 1 juli -> 5 agustus = 36 hari -/ 7 = 5
// 25 maret -> 26 agustus = 84 hari -/ 7 = 12
// 1 januari -> 1 maret = 59 hari -/ 7 = 8