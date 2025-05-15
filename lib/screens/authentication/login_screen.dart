import 'package:flutter/material.dart';
import 'package:generation_stars/screens/MainNavigationScreen.dart';
import 'package:generation_stars/screens/authentication/forgot_pass_screen.dart';
import 'package:generation_stars/screens/authentication/register_screen.dart';
import 'package:generation_stars/shared/shared_button.dart';
import 'package:generation_stars/shared/shared_text_form_field.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:generation_stars/widgets/widget_background.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;

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
                // Logo atau ilustrasi kecil
                SizedBox(
                  height: 150,
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
                    color: ColorsApp.text,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),

                // Subjudul
                Text(
                  'Selamat datang kembali!',
                  style: GoogleFonts.poppins(
                    color: ColorsApp.text.withOpacity(0.7),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 40),

                SharedTextFormField(
                  Controller: emailController,
                  labelText: 'Email',
                  readOnly: false,
                  obsecureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 30),

                SharedTextFormField(
                  Controller: passwordController,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 10),

                // Lupa Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                        ColorsApp.hijau.withOpacity(0.1),
                      ),
                    ),
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
                        color: ColorsApp.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 24),

                // Tombol Masuk
                _widgetButton(),

                SizedBox(height: 16),

                // Sudah punya akun?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum punya akun?',
                      style: GoogleFonts.poppins(
                        color: ColorsApp.grey,
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                          ColorsApp.hijau.withOpacity(0.1),
                        ),
                      ),
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

  Widget _buildInputForm() {
    return Column(
      children: [],
    );
  }

  Widget _widgetButton() {
    return SizedBox(
      width: double.infinity,
      child: SharedButtton(
        title: Text(
          'Masuk',
          style: GoogleFonts.poppins(
              color: ColorsApp.white,
              fontWeight: FontWeight.w600,
              fontSize: 16),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainNavigationScreen(),
            ),
          );
        },
      ),
    );
  }
}
