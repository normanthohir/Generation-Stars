import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generation_stars/screens/MainNavigationScreen.dart';
import 'package:generation_stars/screens/profile_screen.dart';
import 'package:generation_stars/services/profile_service.dart';
import 'package:generation_stars/shared/shared_CircularProgres.dart';
import 'package:generation_stars/shared/shared_appbar.dart';
import 'package:generation_stars/shared/shared_button.dart';
import 'package:generation_stars/shared/shared_text_form_field.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:generation_stars/utils/date_utils.dart' as date_util;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> initialData;

  EditProfileScreen({Key? key, required this.initialData}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _namaController;
  late final TextEditingController _tinggiBadanController;
  late final TextEditingController _beratBadanController;
  late final TextEditingController _alamatController;
  late final TextEditingController _tanggalLahirController;
  late final TextEditingController _tanggalKehamilanController;
  DateTime? _tanggalLahir;
  DateTime? _tanggalKehamilan;
  String? _fotoProfile;
  File? _pilihGambar;
  bool _isLoading = false;
  final userService = UserService();

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.initialData['nama']);
    _tinggiBadanController = TextEditingController(
        text: widget.initialData['tinggi_badan']?.toString());
    _beratBadanController = TextEditingController(
        text: widget.initialData['berat_badan']?.toString());
    _alamatController =
        TextEditingController(text: widget.initialData['alamat']);
    _tanggalLahirController = TextEditingController();
    _tanggalKehamilanController = TextEditingController();
    _fotoProfile = widget.initialData['foto_profile'];

    // Initialize date values
    if (widget.initialData['tanggal_lahir'] != null) {
      _tanggalLahir = DateTime.parse(widget.initialData['tanggal_lahir']);
      _tanggalLahirController.text =
          DateFormat('dd MMMM yyyy').format(_tanggalLahir!);
    }

    if (widget.initialData['tanggal_kehamilan'] != null) {
      _tanggalKehamilan =
          DateTime.parse(widget.initialData['tanggal_kehamilan']);
      _tanggalKehamilanController.text =
          DateFormat('dd MMMM yyyy').format(_tanggalKehamilan!);
    }
  }

  Future<void> _ubahFotoProfile() async {
    final picker = ImagePicker();
    final pilihFile = await picker.pickImage(source: ImageSource.gallery);

    if (pilihFile != null) {
      setState(() {
        _pilihGambar = File(pilihFile.path);
      });
    }
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        await userService.updateProfile(
          nama: _namaController.text,
          tanggalLahir: _tanggalLahirController.text,
          tanggalKehamilan: _tanggalKehamilanController.text,
          tinggiBadan: int.parse(_tinggiBadanController.text),
          beratBadan: int.parse(_beratBadanController.text),
          alamat: _alamatController.text,
          fotoProfile: _pilihGambar,
        );
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Profil berhasil diubah",
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MainNavigationScreen(initialPage: 3)),
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
      appBar: SharedAppbar(
        title: 'Edit Profil',
        ipmlayLeadingFalse: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Foto Profil
              _buildProfilePhotoSection(),
              SizedBox(height: 24),

              // Form Edit
              _buildEditForm(),
              SizedBox(height: 40),

              // Tombol Simpan
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePhotoSection() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: _pilihGambar != null
                  ? FileImage(_pilihGambar!) as ImageProvider<Object>
                  : _fotoProfile != null
                      ? NetworkImage(_fotoProfile!) as ImageProvider<Object>
                      : const AssetImage('assets/images/no_profile.jpg')
                          as ImageProvider<Object>,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorsApp.hijauTua,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                  onPressed: _ubahFotoProfile,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Ubah Foto Profil',
          style: GoogleFonts.poppins(color: ColorsApp.hijauTua, fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildEditForm() {
    return Column(
      children: [
        // Nama
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
          Controller: _tanggalLahirController,
          labelText: 'Tanggal Lahir',
          readOnly: true,
          prefixIcon: Icon(Icons.cake),
          suffixIcon: Icon(Icons.calendar_month),
          onTap: () async {
            final selectedDate = await date_util.DateUtils.selectDate(
              context: context,
              initialDate: _tanggalLahir ?? DateTime(2000),
              firstDate: DateTime(
                  1900), // Changed from 1999 to 1900 for more reasonable range
              lastDate: DateTime.now(),
              fieldName: 'Tanggal Lahir',
            );
            if (selectedDate != null) {
              setState(() {
                _tanggalLahir = selectedDate;
                _tanggalLahirController.text =
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
          Controller: _tanggalKehamilanController,
          labelText: 'Tanggal Kehamilan ',
          readOnly: true,
          prefixIcon: Icon(Icons.child_friendly),
          suffixIcon: Icon(Icons.calendar_month),
          onTap: () async {
            final selectedDate = await date_util.DateUtils.selectDate(
              context: context,
              initialDate: _tanggalKehamilan ?? DateTime.now(),
              firstDate: DateTime.now().subtract(Duration(days: 280)),
              lastDate: DateTime.now(),
              fieldName: 'Tanggal Kehamilan',
            );
            if (selectedDate != null) {
              setState(() {
                _tanggalKehamilan = selectedDate;
                _tanggalKehamilanController.text =
                    DateFormat('dd MMMM yyyy').format(selectedDate);
              });
            }
          },
        ),
        SizedBox(height: 24),

        // Tinggi & Berat Badan
        Row(
          children: [
            Expanded(
              child: SharedTextFormField(
                Controller: _tinggiBadanController,
                labelText: 'Tinggi Badan (cm)',
                keyboardType: TextInputType.number,
                prefixIcon: Icon(Icons.height),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tinggi harus diisi';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Harus berupa angka';
                  }
                  final height = int.parse(value);
                  if (height < 100 || height > 250) {
                    return 'Tinggi badan tidak valid';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: SharedTextFormField(
                Controller: _beratBadanController,
                labelText: 'Berat Badan (kg)',
                keyboardType: TextInputType.number,
                prefixIcon: Icon(Icons.monitor_weight),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Berat badan harus diisi';
                  }
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
          labelText: 'Alamat Lengkap',
          maxLines: 3,
          prefixIcon: Icon(Icons.location_on),
          alignLabelWithHint: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Alamat harus diisi';
            }
            if (value.length < 10) {
              return 'Alamat terlalu pendek';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
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
        onPressed: _saveProfile,
      ),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _tinggiBadanController.dispose();
    _beratBadanController.dispose();
    _alamatController.dispose();
    _tanggalLahirController.dispose();
    _tanggalKehamilanController.dispose();
    super.dispose();
  }
}
