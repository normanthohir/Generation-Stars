import 'package:flutter/material.dart';
import 'package:generation_stars/screens/MainNavigationScreen.dart';
import 'package:generation_stars/screens/authentication/login_screen.dart';
import 'package:generation_stars/screens/lengkapi_profile_screen.dart';
import 'package:generation_stars/services/authentication_service.dart';
import 'package:generation_stars/shared/shared_CircularProgres.dart';
import 'package:generation_stars/shared/shared_button.dart';
import 'package:generation_stars/shared/shared_text_form_field.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:generation_stars/widgets/widget_background.dart';
import 'package:generation_stars/widgets/widget_page_transitions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:email_validator/email_validator.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
  bool _isObscureKonfirm = true;

  final _formKey = GlobalKey<FormState>();
  final authService = AuthService();
  bool _isLoading = false;

  void _register() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      setState(() => _isLoading = true);

      try {
        final response = await authService.regiSter(
          email: email,
          password: password,
        );

        if (response.user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LengkapiProfile(),
            ),
          );
        }
      } on AuthException catch (e) {
        if (e.message.contains('already registered')) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
              message: "Email sudah terdaftar",
            ),
          );
        } else {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
              message: "Terjadi kesalahan: ${e.message}",
            ),
          );
        }
      } catch (e) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: "Terjadi kesalahan: ${e.toString()}",
          ),
        );
      } finally {
        setState(() => _isLoading = false);
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
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                    'Daftar',
                    style: GoogleFonts.poppins(
                      color: ColorsApp.text,
                      fontSize: 36,
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

                  // TextFormField Email
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
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return 'Kata sandi tidak boleh kurang dari 6 karakter!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  // TextFormField Konfirmasi Password
                  SharedTextFormField(
                      Controller: _confirmPasswordController,
                      labelText: 'Konfirmasi Password',
                      readOnly: false,
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
                      }),

                  SizedBox(height: 30),
                  // Tombol Daftar
                  SizedBox(
                    width: double.infinity,
                    child: SharedButtton(
                      title: _isLoading
                          ? SharedCircularprogres()
                          : Text(
                              'Daftar',
                              style: GoogleFonts.poppins(
                                  color: ColorsApp.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                      onPressed: _register,
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
                            CustomPageTransitions.fadeTransition(LoginScreen()),
                          );
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => LoginScreen(),
                          //   ),
                          // );
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
          ),
        ],
      ),
    );
  }
}
