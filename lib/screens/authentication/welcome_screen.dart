import 'package:flutter/material.dart';
import 'package:generation_stars/screens/authentication/login_screen.dart';
import 'package:generation_stars/screens/authentication/register_screen.dart';
import 'package:generation_stars/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              // Gambar ilustrasi
              SizedBox(
                height: 200,
                child: Image.asset(
                  'assets/images/ibu_hamil.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 28),
              Text(
                'Nutrisi Sehat Untuk Ibu Hamil',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  color: Color(0xFF123458),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Bantu penuhi nutrisi selama kehamilan\nuntuk cegah stunting sejak dini.',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  color: Color(0xFF030303),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 40),
              // Tombol "Daftar"
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
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
                    'Daftar',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Tombol "Masuk"
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.buttonBorder,
                    side: BorderSide(color: AppColors.buttonBorder),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Masuk',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
