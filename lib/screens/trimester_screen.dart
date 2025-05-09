import 'package:flutter/material.dart';
import 'package:generation_stars/utils/colors.dart';
import 'package:generation_stars/widgets/NutrisiChart.dart';
import 'package:generation_stars/widgets/shared_appbar.dart';
import 'package:google_fonts/google_fonts.dart';

class TrimesterScreen extends StatelessWidget {
  const TrimesterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: SharedAppbar(title: 'Trimester'),
      body: Column(
        children: [NutrisiChartWidget()],
      ),
    );
  }
}
