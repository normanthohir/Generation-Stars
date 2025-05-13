import 'package:flutter/material.dart';
import 'package:generation_stars/screens/authentication/login_screen.dart';
import 'package:generation_stars/shared/shared_button.dart';
import 'package:generation_stars/shared/shared_text_form_field.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:generation_stars/widgets/widget_background.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  File? _image;
  bool _isObscure = true;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorsApp.white,
      body: Stack(
        children: [
          WidgetBackground(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60),
                // Judul
                Text(
                  'Daftar',
                  style: GoogleFonts.poppins(
                    color: ColorsApp.text,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),

                // Subjudul
                Text(
                  'Buat akun baru untuk memulai',
                  style: GoogleFonts.poppins(
                    color: ColorsApp.text.withOpacity(0.7),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 40),

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

                // TextFormField Nama
                SharedTextFormField(
                  Controller: _nameController,
                  labelText: 'Nama',
                  readOnly: false,
                  obsecureText: false,
                ),

                SizedBox(height: 20),

                // TextFormField Email
                SharedTextFormField(
                  Controller: _emailController,
                  labelText: 'Email',
                  readOnly: false,
                  obsecureText: false,
                ),
                SizedBox(height: 20),

                // TextFormField Password
                SharedTextFormField(
                  Controller: _passwordController,
                  labelText: 'Password',
                  readOnly: false,
                  obsecureText: _isObscure,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),

                // TextFormField Konfirmasi Password
                SharedTextFormField(
                  Controller: _confirmPasswordController,
                  labelText: 'Konfirmasi Password',
                  readOnly: false,
                  obsecureText: _isObscure,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),

                SizedBox(height: 30),
                // Tombol Daftar
                SizedBox(
                  width: double.infinity,
                  child: SharedButtton(
                    title: Text(
                      'Daftar',
                      style: GoogleFonts.poppins(
                          color: ColorsApp.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    onPressed: () {},
                  ),
                ),

                SizedBox(height: 16),

                // Sudah punya akun?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sudah punya akun?',
                      style: GoogleFonts.poppins(
                        color: ColorsApp.grey,
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Masuk',
                        style: GoogleFonts.poppins(
                          color: ColorsApp.hijau,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
