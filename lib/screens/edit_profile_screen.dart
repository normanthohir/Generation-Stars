import 'package:flutter/material.dart';
import 'package:generation_stars/shared/shared_appbar.dart';
import 'package:generation_stars/shared/shared_button.dart';
import 'package:generation_stars/shared/shared_text_form_field.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> initialData;

  const EditProfileScreen({Key? key, required this.initialData})
      : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;
  late TextEditingController _addressController;
  DateTime? _birthDate;
  DateTime? _pregnancyDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialData['name']);
    _heightController =
        TextEditingController(text: widget.initialData['height']?.toString());
    _weightController =
        TextEditingController(text: widget.initialData['weight']?.toString());
    _addressController =
        TextEditingController(text: widget.initialData['address']);
    _birthDate = widget.initialData['birthDate'];
    _pregnancyDate = widget.initialData['pregnancyDate'];
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
              backgroundImage: widget.initialData['photoUrl'] != null
                  ? AssetImage(widget.initialData['photoUrl'])
                  : AssetImage('assets/images/person.png') as ImageProvider,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorsApp.hijau,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                  onPressed: _changePhoto,
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
    return Form(
      child: Column(
        children: [
          // Nama
          SharedTextFormField(
              Controller: _nameController,
              labelText: 'Nama',
              prefixIcon: Icon(Icons.person),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama tidak boleh kosong';
                }
                return null;
              }),

          SizedBox(height: 24),

          // Tanggal Lahir
          InkWell(
            onTap: () => _selectDate(context, isBirthDate: true),
            child: InputDecorator(
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                floatingLabelStyle: GoogleFonts.poppins(color: ColorsApp.text),
                labelText: 'Tanggal Lahir',
                prefixIcon: Icon(Icons.cake),
                fillColor: Colors.transparent,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: ColorsApp.text.withOpacity(0.5), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: ColorsApp.text.withOpacity(0.6), width: 2),
                ),
                focusColor: ColorsApp.hijau,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _birthDate != null
                        ? DateFormat('dd MMMM yyyy').format(_birthDate!)
                        : 'Pilih Tanggal',
                  ),
                  Icon(Icons.calendar_today, size: 20),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),

          // Tanggal Kehamilan
          InkWell(
            onTap: () => _selectDate(context, isBirthDate: false),
            child: InputDecorator(
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                floatingLabelStyle: GoogleFonts.poppins(color: ColorsApp.text),
                labelText: 'Tanggal Awal Kehamilan (Opsional)',
                labelStyle: GoogleFonts.poppins(color: ColorsApp.text),
                prefixIcon: Icon(Icons.child_friendly),
                fillColor: Colors.transparent,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: ColorsApp.text.withOpacity(0.5), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: ColorsApp.text.withOpacity(0.6), width: 2),
                ),
                focusColor: ColorsApp.hijau,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _pregnancyDate != null
                        ? DateFormat('dd MMMM yyyy').format(_pregnancyDate!)
                        : 'Pilih Tanggal',
                  ),
                  Icon(Icons.calendar_today, size: 20),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),

          // Tinggi & Berat Badan
          Row(
            children: [
              Expanded(
                  child: SharedTextFormField(
                keyboardType: TextInputType.number,
                Controller: _heightController,
                labelText: 'Tinggi Badan (cm)',
                prefixIcon: Icon(Icons.height),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tinggi harus diisi';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Harus angka';
                  }
                  return null;
                },
              )),
              SizedBox(width: 16),
              Expanded(
                child: SharedTextFormField(
                  keyboardType: TextInputType.number,
                  Controller: _weightController,
                  labelText: 'Berat Badan (kg)',
                  prefixIcon: Icon(Icons.monitor_weight),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Berat harus diisi';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Harus angka';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 24),

          SharedTextFormField(
            Controller: _addressController,
            maxLines: 3,
            labelText: 'Alamat Lengkap',
            prefixIcon: Icon(Icons.location_on),
            alignLabelWithHint: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Alamat harus diisi';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
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
          onPressed: () {}),
    );
  }

  Future<void> _selectDate(BuildContext context,
      {required bool isBirthDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isBirthDate
          ? _birthDate ?? DateTime.now()
          : _pregnancyDate ?? DateTime.now(),
      firstDate: isBirthDate
          ? DateTime(1900)
          : DateTime.now().subtract(Duration(days: 280)),
      lastDate: isBirthDate ? DateTime.now() : DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        if (isBirthDate) {
          _birthDate = picked;
        } else {
          _pregnancyDate = picked;
        }
      });
    }
  }

  void _changePhoto() {
    // Implementasi pemilihan foto
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Ubah Foto Profil'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('Ambil Foto'),
              onTap: () {
                Navigator.pop(context);
                // _takePhoto();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Pilih dari Galeri'),
              onTap: () {
                Navigator.pop(context);
                // _pickPhoto();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _saveProfile() {
    // Validasi dan simpan data
    // Navigator.pop(context); // Kembali ke halaman profil
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profil berhasil diperbarui')),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
