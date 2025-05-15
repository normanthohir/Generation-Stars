import 'dart:io';

import 'package:flutter/material.dart';
import 'package:generation_stars/screens/MainNavigationScreen.dart';
import 'package:generation_stars/shared/shared_appbar.dart';
import 'package:generation_stars/shared/shared_button.dart';
import 'package:generation_stars/shared/shared_text_form_field.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:generation_stars/utils/date_utils.dart' as date_util;

class LengkapiProfile extends StatefulWidget {
  LengkapiProfile({super.key});

  @override
  State<LengkapiProfile> createState() => _LengkapiProfileState();
}

class _LengkapiProfileState extends State<LengkapiProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tinggibadanController = TextEditingController();
  final TextEditingController _beratbadanController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _tanggallahirController = TextEditingController();
  final TextEditingController _tanggalkehamilanController =
      TextEditingController();
  DateTime? _birthDate;
  DateTime? _pregnancyDate;
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_birthDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tanggal lahir harus diisi')),
        );
        return;
      }

      // Proses penyimpanan data
      final profileData = {
        'name': _namaController.text,
        'birthDate': _birthDate,
        'pregnancyDate': _pregnancyDate,
        'height': int.parse(_tinggibadanController.text),
        'weight': int.parse(_beratbadanController.text),
        'address': _alamatController.text,
      };

      // Simpan data dan navigasi ke halaman utama
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profil berhasil disimpan')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MainNavigationScreen(), // Ganti dengan halaman utama Anda
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.white,
      appBar: SharedAppbar(
        title: 'Lengkapi Profile',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Header Informasi
              _buildHeaderInfo(),
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
    );
  }

  Widget _buildHeaderInfo() {
    return Column(
      children: [
        Icon(
          Icons.account_circle,
          size: 80,
          color: ColorsApp.hijau,
        ),
        SizedBox(height: 16),
        Text(
          'Lengkapi data diri Anda',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: ColorsApp.text,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Data ini akan membantu kami memberikan pengalaman terbaik',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: ColorsApp.text.withOpacity(0.7),
          ),
        ),
      ],
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
          title: Text(
            'Simpan',
            style: GoogleFonts.poppins(
              color: ColorsApp.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          onPressed: _submitForm),
    );
  }

  @override
  void dispose() {
    _tanggallahirController.dispose();
    _tanggalkehamilanController.dispose();
    super.dispose();
  }
}
