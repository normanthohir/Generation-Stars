import 'package:flutter/material.dart';
import 'package:generation_stars/screens/authentication/login_screen.dart';
import 'package:generation_stars/shared/shared_CircularProgres.dart';
import 'package:generation_stars/shared/shared_button.dart';
import 'package:generation_stars/shared/shared_text_form_field.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:generation_stars/widgets/widget_background.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ResetPass extends StatefulWidget {
  final String email;
  ResetPass({Key? key, required this.email}) : super(key: key);

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  late String _email;
  final _tokenController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isObscure = true;
  bool _isObscureKonfirm = true;

  final _fromKey = GlobalKey<FormState>();
  bool _isloading = false;

  @override
  void initState() {
    super.initState();
    _email = widget.email; // Auto-isi dari halaman sebelumnya
  }

  Future<void> _resetPassword() async {
    if (_fromKey.currentState!.validate()) {
      setState(() => _isloading = true);
      try {
        final supabase = Supabase.instance.client;
        // 1. Verifikasi token dari email
        await supabase.auth.verifyOTP(
          email: _email,
          token: _tokenController.text,
          type: OtpType.recovery,
        );

        // 2. Setelah berhasil login via token, ubah password
        await supabase.auth.updateUser(
          UserAttributes(password: _passwordController.text),
        );
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Password berhasil direset. Silakan login.",
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      } on AuthException catch (e) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Gagal: ${e.message}",
          ),
        );
      } catch (e) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Terjadi kesalahan: $e",
          ),
        );
        print('terjadi keselahan $e');
      }
      setState(() => _isloading = false);
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
              key: _fromKey,
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
                    Controller: _tokenController,
                    labelText: 'Token',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Token tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),

                  // Input Password Baru
                  SharedTextFormField(
                    Controller: _passwordController,
                    labelText: 'Password Baru',
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
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return 'Kata sandi tidak boleh kurang dari 6 karakter!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),

                  // Input Konfirmasi Password Baru
                  SharedTextFormField(
                    Controller: _confirmPasswordController,
                    labelText: 'Konfirmasi Password Baru',
                    obsecureText: _isObscureKonfirm,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscureKonfirm
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscureKonfirm = !_isObscureKonfirm;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return 'Kata sandi tidak boleh kurang dari 6 karakter!';
                      }
                      if (value != _passwordController.text) {
                        return 'Konfirmasi kata sandi tidak cocok!';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 30),

                  // Tombol Reset Password
                  SizedBox(
                    width: double.infinity,
                    child: SharedButtton(
                      title: _isloading
                          ? SharedCircularprogres()
                          : Text(
                              'Reset Password',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                      onPressed: _resetPassword,
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

  @override
  void dispose() {
    _tokenController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
