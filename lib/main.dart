import 'package:flutter/material.dart';
import 'package:generation_stars/screens/MainNavigationScreen.dart';
import 'package:generation_stars/screens/authentication/welcome_screen.dart';
import 'package:generation_stars/screens/home_page.dart';
import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
    );
  }
}
