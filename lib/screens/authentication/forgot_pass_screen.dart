import 'package:flutter/material.dart';
import 'package:generation_stars/screens/authentication/resset_pass_screen.dart';
import 'package:generation_stars/shared/shared_button.dart';
import 'package:generation_stars/shared/shared_text_form_field.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:generation_stars/widgets/widget_background.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPass extends StatelessWidget {
  ForgotPass({Key? key}) : super(key: key);
  final emailController = TextEditingController();

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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_reset,
                  size: 110,
                  color: ColorsApp.black,
                ),
                SizedBox(height: 24),
                Text(
                  'Lupa Password',
                  style: GoogleFonts.poppins(
                    color: ColorsApp.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Masukkan email Anda untuk mendapatkan Token reset password.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: ColorsApp.grey,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 40),
                SharedTextFormField(
                  Controller: emailController,
                  labelText: 'Email',
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: SharedButtton(
                    title: Text(
                      'Kirim Token',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResetPass(),
                        ),
                      );
                    },
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
