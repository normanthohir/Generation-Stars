import 'dart:io';

import 'package:flutter/material.dart';
import 'package:generation_stars/screens/MainNavigationScreen.dart';
import 'package:generation_stars/services/authentication_service.dart';
import 'package:generation_stars/shared/shared_CircularProgres.dart';
import 'package:generation_stars/shared/shared_button.dart';
import 'package:generation_stars/shared/shared_text_form_field.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:generation_stars/widgets/widget_background.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:generation_stars/utils/date_utils.dart' as date_util;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LengkapiProfile extends StatefulWidget {
  LengkapiProfile({super.key});

  @override
  State<LengkapiProfile> createState() => _LengkapiProfileState();
}

class _LengkapiProfileState extends State<LengkapiProfile> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tinggibadanController = TextEditingController();
  final TextEditingController _beratbadanController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _tanggallahirController = TextEditingController();
  final TextEditingController _tanggalkehamilanController =
      TextEditingController();
  File? _image;
  DateTime? _birthDate;
  DateTime? _pregnancyDate;

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _simpan() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final supabase = Supabase.instance.client;
      final userId = supabase.auth.currentUser!.id;
      final nama = _namaController.text;
      final tanggalLahir = _birthDate?.toIso8601String();
      final tanggalKehamilan = _pregnancyDate!.toIso8601String();
      final tinggiBadan = int.tryParse(_tinggibadanController.text);
      final beratBadan = int.tryParse(_beratbadanController.text);
      final alamat = _alamatController.text;

      String? imageUrl;

      if (_image != null) {
        try {
          final bytes = await _image!.readAsBytes();
          final path =
              'foto-profile/${userId}_${DateTime.now().millisecondsSinceEpoch}.jpg';

          // Upload gambar
          await supabase.storage.from('foto-profile').uploadBinary(path, bytes);

          // Ambil URL publik
          imageUrl = supabase.storage.from('foto-profile').getPublicUrl(path);
        } catch (e) {
          print("gagal upload foto profil: $e");
        }
      }

      try {
        await supabase.from('profile').upsert({
          'id': userId,
          'nama': nama,
          'tanggal_lahir': tanggalLahir,
          'tanggal_kehamilan': tanggalKehamilan,
          'tinggi_badan': tinggiBadan,
          'berat_badan': beratBadan,
          'alamat': alamat,
          'foto_profile': imageUrl,
        });
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Lengkapi profile berhasil",
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainNavigationScreen(),
          ),
        );
      } catch (e) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: "Gagal menyimpan profil: $e",
          ),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          WidgetBackground(),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Header Informasi
                  Text(
                    'Lengkapi Profil',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: ColorsApp.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Data ini akan membantu kami memberikan pengalaman terbaik',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: ColorsApp.grey,
                    ),
                  ),

                  SizedBox(height: 24),
                  // Form Input
                  _buildInputForm(),

                  SizedBox(height: 40),
                  // Tombol Simpan
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputForm() {
    return Column(
      children: [
        // Foto Profil
        GestureDetector(
          onTap: _pickImage,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: ColorsApp.grey,
            backgroundImage: _image != null ? FileImage(_image!) : null,
            child: _image == null
                ? Icon(
                    Icons.camera_alt,
                    color: AppColors.background,
                    size: 30,
                  )
                : null,
          ),
        ),
        SizedBox(height: 24),
        // Nama Lengkap
        SharedTextFormField(
          Controller: _namaController,
          labelText: 'Nama',
          prefixIcon: Icon(Icons.person),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Nama tidak boleh kosong';
            }
            return null;
          },
        ),
        SizedBox(height: 24),

        // Tanggal Lahir
        SharedTextFormField(
          Controller: _tanggallahirController,
          labelText: 'Tanggal Lahir',
          readOnly: true,
          prefixIcon: Icon(Icons.cake),
          suffixIcon: Icon(Icons.calendar_month),
          onTap: () async {
            final selectedDate = await date_util.DateUtils.selectDate(
              context: context,
              initialDate: _birthDate ?? DateTime(2000),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              fieldName: 'Tanggal Lahir',
            );
            if (selectedDate != null) {
              setState(() {
                _birthDate = selectedDate;
                _tanggallahirController.text =
                    DateFormat('dd MMMM yyyy').format(selectedDate);
              });
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Tanggal lahir harus diisi';
            }
            return null;
          },
        ),

        SizedBox(height: 24),
        // Tanggal Kehamilan
        SharedTextFormField(
          Controller: _tanggalkehamilanController,
          labelText: 'Tanggal Kehamilan',
          readOnly: true,
          suffixIcon: Icon(Icons.calendar_month),
          prefixIcon: Icon(Icons.child_friendly),
          onTap: () async {
            final selectedDate = await date_util.DateUtils.selectDate(
              context: context,
              initialDate: _pregnancyDate ?? DateTime.now(),
              firstDate: DateTime.now().subtract(Duration(days: 280)),
              lastDate: DateTime.now(),
              fieldName: 'Tanggal Kehamilan',
            );
            if (selectedDate != null) {
              setState(() {
                _pregnancyDate = selectedDate;
                _tanggalkehamilanController.text =
                    DateFormat('dd MMMM yyyy').format(selectedDate);
              });
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Tanggal kehamilan harus diisi';
            }
            return null;
          },
        ),
        SizedBox(height: 24),

        // Tinggi & Berat Badan
        Row(
          children: [
            Expanded(
              child: SharedTextFormField(
                Controller: _tinggibadanController,
                keyboardType: TextInputType.number,
                labelText: 'Tinggi Badan (cm)',
                prefixIcon: Icon(Icons.height),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tinggi harus diisi';
                  }
                  final height = int.tryParse(value);
                  if (height == null) return 'Harus berupa angka';
                  if (height < 100 || height > 250) return 'Tinggi tidak valid';
                  return null;
                },
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: SharedTextFormField(
                Controller: _beratbadanController,
                keyboardType: TextInputType.number,
                labelText: 'Berat Badan (kg)',
                prefixIcon: Icon(Icons.monitor_weight),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Berat harus diisi';
                  }
                  final weight = int.tryParse(value);
                  if (weight == null) return 'Harus berupa angka';
                  if (weight < 30 || weight > 200) return 'Berat tidak valid';
                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 24),

        // Alamat
        SharedTextFormField(
          Controller: _alamatController,
          maxLines: 3,
          labelText: 'Alamat Lengkap',
          prefixIcon: Icon(Icons.location_on),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Alamat harus diisi';
            }
            if (value.length < 10) return 'Alamat terlalu pendek';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: SharedButtton(
        title: _isLoading
            ? SharedCircularprogres()
            : Text(
                'Simpan',
                style: GoogleFonts.poppins(
                  color: ColorsApp.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
        onPressed: _simpan,
      ),
    );
  }
}
