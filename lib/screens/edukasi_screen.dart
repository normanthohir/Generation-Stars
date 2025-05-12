import 'package:flutter/material.dart';
import 'package:generation_stars/shared/shared_appbar.dart';
import 'package:generation_stars/widgets/widgets_carousel_%20fullscreen.dart';

class EdukasiScreen extends StatelessWidget {
  EdukasiScreen({super.key});

  final List<String> imageAssets = [
    'assets/images/edukasi/1.png',
    'assets/images/edukasi/2.png',
    'assets/images/edukasi/3.png',
    'assets/images/edukasi/4.png',
    'assets/images/edukasi/5.png',
    'assets/images/edukasi/6.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedAppbar(
        title: 'Edukasi Stanting',
        ipmlayLeadingFalse: true,
      ),
      body: ModernImageCarousel(imageAssets: imageAssets),
    );
  }
}
