import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generation_stars/shared/shared_appbar.dart';
import 'package:generation_stars/shared/shared_button.dart';
import 'package:generation_stars/shared/shared_text_form_field.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:generation_stars/utils/date_utils.dart' as date_util;

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> initialData;

  EditProfileScreen({Key? key, required this.initialData}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _heightController;
  late final TextEditingController _weightController;
  late final TextEditingController _addressController;
  late final TextEditingController _birthDateController;
  late final TextEditingController _pregnancyDateController;
  DateTime? _birthDate;
  DateTime? _pregnancyDate;
  String? _photoUrl;

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
    _birthDateController = TextEditingController();
    _pregnancyDateController = TextEditingController();
    _photoUrl = widget.initialData['photoUrl'];

    // Initialize date values
    if (widget.initialData['birthDate'] != null) {
      _birthDate = widget.initialData['birthDate'];
      _birthDateController.text =
          DateFormat('dd MMMM yyyy').format(_birthDate!);
    }

    if (widget.initialData['pregnancyDate'] != null) {
      _pregnancyDate = widget.initialData['pregnancyDate'];
      _pregnancyDateController.text =
          DateFormat('dd MMMM yyyy').format(_pregnancyDate!);
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
              backgroundImage: _photoUrl != null
                  ? AssetImage(_photoUrl!)
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
      key: _formKey,
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
            },
          ),
          SizedBox(height: 24),

          // Tanggal Lahir
          SharedTextFormField(
            Controller: _birthDateController,
            labelText: 'Tanggal Lahir',
            readOnly: true,
            prefixIcon: Icon(Icons.cake),
            suffixIcon: Icon(Icons.calendar_month),
            onTap: () async {
              final selectedDate = await date_util.DateUtils.selectDate(
                context: context,
                initialDate: _birthDate ?? DateTime(2000),
                firstDate: DateTime(
                    1900), // Changed from 1999 to 1900 for more reasonable range
                lastDate: DateTime.now(),
                fieldName: 'Tanggal Lahir',
              );
              if (selectedDate != null) {
                setState(() {
                  _birthDate = selectedDate;
                  _birthDateController.text =
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
            Controller: _pregnancyDateController,
            labelText: 'Tanggal Kehamilan (Opsional)',
            readOnly: true,
            prefixIcon: Icon(Icons.child_friendly),
            suffixIcon: Icon(Icons.calendar_month),
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
                  _pregnancyDateController.text =
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
                  Controller: _heightController,
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
                  Controller: _weightController,
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
            Controller: _addressController,
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
        onPressed: _saveProfile,
      ),
    );
  }

  Future<void> _changePhoto() async {
    // Implementasi perubahan foto profil
    // ...
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // if (_birthDate == null) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Tanggal lahir harus diisi')),
      //   );
      //   return;
      // }

      // Validasi form
      // if (_nameController.text.isEmpty ||
      //     _heightController.text.isEmpty ||
      //     _weightController.text.isEmpty ||
      //     _addressController.text.isEmpty) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Harap isi semua field yang wajib')),
      //   );
      //   return;
      // }

      // Simpan data
      final updatedData = {
        'name': _nameController.text,
        'birthDate': _birthDate,
        'pregnancyDate': _pregnancyDate,
        'height': int.parse(_heightController.text),
        'weight': int.parse(_weightController.text),
        'address': _addressController.text,
        'photoUrl': _photoUrl,
      };

      Navigator.pop(context, updatedData);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _addressController.dispose();
    _birthDateController.dispose();
    _pregnancyDateController.dispose();
    super.dispose();
  }
}
