import 'package:flutter/material.dart';
import 'package:generation_stars/screens/MainNavigationScreen.dart';
import 'package:generation_stars/screens/authentication/forgot_pass_screen.dart';
import 'package:generation_stars/screens/authentication/register_screen.dart';
import 'package:generation_stars/screens/home_screen.dart';
import 'package:generation_stars/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60),

              // Logo atau ilustrasi kecil
              SizedBox(
                height: 120,
                child: Image.asset(
                  'assets/images/ibu_hamil.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 24),

              // Judul
              Text(
                'Masuk',
                style: GoogleFonts.poppins(
                  color: AppColors.heading,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),

              // Subjudul
              Text(
                'Selamat datang kembali!',
                style: GoogleFonts.poppins(
                  color: AppColors.subtext,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 40),

              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: GoogleFonts.poppins(
                    color: AppColors.heading,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              SizedBox(height: 20),

              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: GoogleFonts.poppins(
                    color: AppColors.heading,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Lupa Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ForgotPass(),
                      ),
                    );
                  },
                  child: Text(
                    'Lupa Password?',
                    style: GoogleFonts.poppins(
                      color: AppColors.heading,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Tombol Masuk
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MainNavigationScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonText,
                    foregroundColor: Color(0xFFF1EFEC),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Masuk',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Sudah punya akun?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun?',
                    style: GoogleFonts.poppins(
                      color: AppColors.subtext,
                      fontSize: 14,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Daftar',
                      style: GoogleFonts.poppins(
                        color: AppColors.heading,
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
      ),
    );
  }
}
