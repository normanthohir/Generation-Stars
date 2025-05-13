import 'package:flutter/material.dart';
import 'package:generation_stars/shared/shared_button.dart';
import 'package:generation_stars/shared/shared_text_form_field.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:generation_stars/widgets/widget_background.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPass extends StatelessWidget {
  ResetPass({Key? key}) : super(key: key);
  final tokenController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.vpn_key,
                  size: 100,
                  color: ColorsApp.black,
                ),
                SizedBox(height: 24),

                Text(
                  'Reset Password',
                  style: GoogleFonts.poppins(
                    color: ColorsApp.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),

                Text(
                  'Masukkan Token dan Password baru Anda.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: ColorsApp.grey,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 40),

                // Input Token
                SharedTextFormField(
                  Controller: tokenController,
                  labelText: 'Token',
                ),
                SizedBox(height: 30),

                // Input Password Baru
                SharedTextFormField(
                  Controller: passwordController,
                  labelText: 'Password Baru',
                  obsecureText: true,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.visibility_off),
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 30),

                // Input Konfirmasi Password Baru
                SharedTextFormField(
                  Controller: confirmPasswordController,
                  labelText: 'Konfirmasi Password Baru',
                  obsecureText: true,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.visibility_off),
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 30),

                // Tombol Reset Password
                SizedBox(
                  width: double.infinity,
                  child: SharedButtton(
                    title: Text(
                      'Reset Password',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                      ColorsApp.hijau.withOpacity(0.1),
                    ),
                  ),
                  child: Text(
                    'Kembali ke Masuk',
                    style: GoogleFonts.poppins(
                      color: ColorsApp.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
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
