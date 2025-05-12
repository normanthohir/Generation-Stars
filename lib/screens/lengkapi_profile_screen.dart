import 'package:flutter/material.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class LengkapiProfileScreen extends StatefulWidget {
  LengkapiProfileScreen({Key? key}) : super(key: key);

  @override
  State<LengkapiProfileScreen> createState() => _LengkapiProfileScreenState();
}

class _LengkapiProfileScreenState extends State<LengkapiProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  DateTime? selectedDate;
  final TextEditingController tanggalLahirController = TextEditingController();
  final TextEditingController usiaKehamilanController = TextEditingController();
  final TextEditingController beratBadanController = TextEditingController();
  final TextEditingController tinggiBadanController = TextEditingController();
  final TextEditingController statusKehamilanController =
      TextEditingController();
  final TextEditingController alergiMakananController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime(2000),
      firstDate: DateTime(1960),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        tanggalLahirController.text =
            "${picked.day}-${picked.month}-${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.button,
        title: Text(
          "Lengkapi Profil",
          style: GoogleFonts.montserrat(color: AppColors.heading),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 20),
              _buildLabel("Tanggal Lahir"),
              TextFormField(
                controller: tanggalLahirController,
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: _inputDecoration("Pilih tanggal lahir"),
              ),
              SizedBox(height: 16),
              _buildLabel("Usia Kehamilan (minggu)"),
              TextFormField(
                controller: usiaKehamilanController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration("Contoh: 12"),
              ),
              SizedBox(height: 16),
              _buildLabel("Berat Badan (kg)"),
              TextFormField(
                controller: beratBadanController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration("Contoh: 65.5"),
              ),
              SizedBox(height: 16),
              _buildLabel("Tinggi Badan (cm)"),
              TextFormField(
                controller: tinggiBadanController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration("Contoh: 160"),
              ),
              SizedBox(height: 16),
              _buildLabel("Status Kehamilan"),
              DropdownButtonFormField<String>(
                value: statusKehamilanController.text.isNotEmpty
                    ? statusKehamilanController.text
                    : null,
                decoration: _inputDecoration("Pilih status kehamilan"),
                items: [
                  'Trimester 1',
                  'Trimester 2',
                  'Trimester 3',
                ].map((status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    statusKehamilanController.text = value ?? '';
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Status kehamilan wajib diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.button,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Simpan Profil",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: AppColors.heading,
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.buttonBorder),
      ),
    );
  }
}
