import 'package:flutter/material.dart';
import 'package:generation_stars/screens/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://liscdwfbemhakvgdhszq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imxpc2Nkd2ZiZW1oYWt2Z2Roc3pxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDcyODYxNDYsImV4cCI6MjA2Mjg2MjE0Nn0.atAdLp2Sau-oidDCL-jTKUgvaXowt_jTE5yKnLRHo4o',
  );
  runApp(MyApp());
}

// void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
