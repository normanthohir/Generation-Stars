import 'package:flutter/material.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:generation_stars/widgets/widget_nutrisi_chart.dart';
import 'package:generation_stars/shared/shared_appbar.dart';
import 'package:google_fonts/google_fonts.dart';

class TrimesterScreen extends StatelessWidget {
  const TrimesterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.white,
      appBar: SharedAppbar(title: 'Trimester'),
      body: Column(
        children: [NutrisiChartWidget()],
      ),
    );
  }
}
