import 'package:flutter/material.dart';
import 'package:generation_stars/screens/authentication/login_screen.dart';
import 'package:generation_stars/screens/authentication/register_screen.dart';
import 'package:generation_stars/shared/shared_button.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:generation_stars/widgets/widget_background.dart';
import 'package:generation_stars/widgets/widget_page_transitions.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.white,
      body: Stack(
        children: [
          WidgetBackground(), // Using the background widget here
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                // Gambar ilustrasi
                SizedBox(
                  height: 250,
                  child: Image.asset(
                    'assets/images/ibu_hamil.png',
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: 28),
                Text(
                  'Nutrisi Sehat Untuk Ibu Hamil',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: ColorsApp.black.withOpacity(0.8),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Bantu penuhi nutrisi selama kehamilan\nuntuk cegah stunting sejak dini.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: ColorsApp.black.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 40),
                // Tombol "Daftar"
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
                    onPressed: () => Navigator.of(context).push(
                      CustomPageTransitions.slideTransition(RegisterScreen()),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Tombol "Masuk"
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).push(
                      CustomPageTransitions.slideTransition(LoginScreen()),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: ColorsApp.hijau,
                      side: BorderSide(color: ColorsApp.hijau),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Masuk',
                      style: GoogleFonts.poppins(
                          color: ColorsApp.hijau,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
