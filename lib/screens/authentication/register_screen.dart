import 'package:flutter/material.dart';
import 'package:generation_stars/screens/authentication/login_screen.dart';
import 'package:generation_stars/screens/lengkapi_profile_screen.dart';
import 'package:generation_stars/services/authentication_service.dart';
import 'package:generation_stars/shared/shared_button.dart';
import 'package:generation_stars/shared/shared_text_form_field.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:generation_stars/widgets/widget_background.dart';
import 'package:generation_stars/widgets/widget_custom_snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isObscure = true;

  final authService = AuthService();
  bool _isLoading = false;

  void _register() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      CustomSnackbar.show(
        context: context,
        message: "Password & konfirmasi password tidak cocok",
        type: SnackbarType.error,
      );
    }
    setState(() => _isLoading = true);

    try {
      final response = await authService.signUpWithPassword(
          email: email, password: password);
      if (response.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LengkapiProfile(),
          ),
        );
      }
    } catch (e) {
      if (e is AuthApiException && e.message.contains('email')) {
        CustomSnackbar.show(
          context: context,
          message: "Email sudah terdaftar",
          type: SnackbarType.info,
        );
      } else {
        CustomSnackbar.show(
          context: context,
          message: "Gagal mendaftar: $e",
          type: SnackbarType.error,
        );
      }
    } finally {
      setState(() => _isLoading = false);
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

                // SizedBox(height: 24),

                // TextFormField Nama
                // SharedTextFormField(
                //   Controller: _nameController,
                //   labelText: 'Nama',
                //   readOnly: false,
                //   obsecureText: false,
                // ),

                // SizedBox(height: 20),

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
                    title: _isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            'Daftar',
                            style: GoogleFonts.poppins(
                                color: ColorsApp.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                    onPressed: _isLoading ? () {} : _register,
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
