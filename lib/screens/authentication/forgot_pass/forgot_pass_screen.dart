import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:generation_stars/screens/authentication/forgot_pass/resset_pass_screen.dart';
import 'package:generation_stars/shared/shared_CircularProgres.dart';
import 'package:generation_stars/shared/shared_button.dart';
import 'package:generation_stars/shared/shared_text_form_field.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:generation_stars/widgets/widget_background.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// kawalstunting@gmail.com
class ForgotPass extends StatefulWidget {
  ForgotPass({Key? key}) : super(key: key);

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final _emailController = TextEditingController();
  final _fromkey = GlobalKey<FormState>();
  final supabase = Supabase.instance.client;
  bool _isloading = false;

  Future<void> _tokenReset() async {
    if (_fromkey.currentState!.validate()) {
      setState(() => _isloading = true);

      try {
        await supabase.auth.resetPasswordForEmail(
          _emailController.text.trim(),
        );
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: ColorsApp.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              "Berhasil!",
              style: GoogleFonts.poppins(),
              textAlign: TextAlign.center,
            ),
            content: Text(
              "Silakan periksa email Anda untuk token reset password.",
              style: GoogleFonts.poppins(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            actions: [
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ResetPass(email: _emailController.text.trim()),
                      ),
                    );
                  },
                  child: Text(
                    "Ke Halaman Reset Password",
                    style: GoogleFonts.poppins(),
                  ),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                      ColorsApp.white.withOpacity(0.2),
                    ),
                    foregroundColor: MaterialStateProperty.all(ColorsApp.white),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 12, horizontal: 16)),
                    backgroundColor: MaterialStateProperty.all(ColorsApp.hijau),
                  ),
                ),
              ),
            ],
          ),
        );
      } catch (e) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: "Terjadi kesalahan: ${e.toString()}",
          ),
        );
      } finally {
        setState(() => _isloading = false);
      }
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
            child: Form(
              key: _fromkey,
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
                    Controller: _emailController,
                    labelText: 'Email',
                    readOnly: false,
                    obsecureText: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => !EmailValidator.validate(value!)
                        ? 'Format Email Salah!'
                        : null,
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: SharedButtton(
                      title: _isloading
                          ? SharedCircularprogres()
                          : Text(
                              'Kirim Token',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                      onPressed: _tokenReset,
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
          ),
        ],
      ),
    );
  }
}
