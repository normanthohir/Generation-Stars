import 'package:flutter/material.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPass extends StatelessWidget {
  const ResetPass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),

              Icon(
                Icons.vpn_key,
                size: 100,
                color: AppColors.buttonText,
              ),
              const SizedBox(height: 24),

              Text(
                'Reset Password',
                style: GoogleFonts.montserrat(
                  color: AppColors.heading,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              Text(
                'Masukkan Token dan Password baru Anda.',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  color: AppColors.subtext,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),

              // Input Token
              TextField(
                decoration: InputDecoration(
                  labelText: 'Token',
                  labelStyle: GoogleFonts.montserrat(
                    color: AppColors.heading,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Input Password Baru
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password Baru',
                  labelStyle: GoogleFonts.montserrat(
                    color: AppColors.heading,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Input Konfirmasi Password Baru
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Konfirmasi Password',
                  labelStyle: GoogleFonts.montserrat(
                    color: AppColors.heading,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Tombol Reset Password
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonText,
                    foregroundColor: const Color(0xFFF1EFEC),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Reset Password',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Kembali ke Masuk',
                  style: GoogleFonts.montserrat(
                    color: AppColors.heading,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
