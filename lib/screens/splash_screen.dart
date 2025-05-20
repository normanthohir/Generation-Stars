import 'package:flutter/material.dart';
import 'package:generation_stars/screens/MainNavigationScreen.dart';
import 'package:generation_stars/screens/authentication/welcome_screen.dart';
import 'package:generation_stars/screens/lengkapi_profile_screen.dart';
import 'package:generation_stars/shared/shared_CircularProgres.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<Color?> _bgColorAnimation;
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2500),
    );

    // Setup animations
    _setupAnimations();

    // Start animation
    _controller.forward();

    // Check user session after animations complete
    Future.delayed(Duration(milliseconds: 3000), checkSession);
  }

  void _setupAnimations() {
    // Fade animation for logo and text
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 0.5, curve: Curves.easeInOut),
    );

    // Scale (pulse) animation
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.8, end: 1.2), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Slide up animation
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.3, 0.8, curve: Curves.easeOut),
    ));

    // Background color transition
    _bgColorAnimation = ColorTween(
      begin: ColorsApp.hijau,
      end: ColorsApp.white,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.6, 1.0),
    ));
  }

  // void checkSession() {
  //   final session = supabase.auth.currentSession;
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) =>
  //           session != null ? MainNavigationScreen() : WelcomeScreen(),
  //     ),
  //   );
  // }
  Future<void> checkSession() async {
    final session = Supabase.instance.client.auth.currentSession;

    if (session != null) {
      final userId = session.user!.id;

      // Periksa apakah profil pengguna sudah ada
      final profile = await Supabase.instance.client
          .from('profile')
          .select('id')
          .eq('id', userId)
          .maybeSingle();

      if (profile == null) {
        await Supabase.instance.client.auth.signOut();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomeScreen(),
          ),
        );
      } else {
        // Profil sudah ada, arahkan ke halaman home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainNavigationScreen(),
          ),
        );
      }
    } else {
      // Tidak ada sesi aktif, arahkan ke halaman selamat datang
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: _bgColorAnimation.value,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Logo
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15,
                              spreadRadius: 2,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.asset(
                            'assets/images/icons.png',
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // App Name with Animation
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      children: [
                        Text(
                          'Generation Stars',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: _controller.value < 0.6
                                ? Colors.white
                                : ColorsApp.hijau,
                          ),
                        ),
                        SizedBox(height: 20),
                        LoadingAnimationWidget.staggeredDotsWave(
                          color: _controller.value < 0.6
                              ? Colors.white
                              : ColorsApp.hijau,
                          size: 66,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // Loading Indicator (appears later)
                if (_controller.value > 0.7)
                  FadeTransition(
                    opacity: Tween(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: Interval(0.7, 1.0),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
