import 'package:flutter/material.dart';
import 'dart:math';

import 'package:generation_stars/theme/colors.dart';

class WidgetsNutrisiMingguan extends StatelessWidget {
  final double totalKalori;
  final double totalProtein;
  final double totalKarbo;
  final double totalLemak;

  // Constructor dengan nilai default random
  WidgetsNutrisiMingguan({
    double? totalKalori,
    double? totalProtein,
    double? totalKarbo,
    double? totalLemak,
    super.key,
  })  : totalKalori = totalKalori ?? Random().nextDouble() * 2000 + 1000,
        totalProtein = totalProtein ?? Random().nextDouble() * 100 + 30,
        totalKarbo = totalKarbo ?? Random().nextDouble() * 300 + 100,
        totalLemak = totalLemak ?? Random().nextDouble() * 100 + 30;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // color: AppColors.background,
          // borderRadius: BorderRadius.circular(20),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.2),
          //     blurRadius: 10,
          //     offset: const Offset(0, 4),
          //   )
          // ],
          ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Progres Mingguan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Kehamilan minggu ke 12',
            style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _nutrisiBox('Kalori', '${totalKalori.toStringAsFixed(0)} kcal',
                  Colors.orange),
              _nutrisiBox('Protein', '${totalProtein.toStringAsFixed(1)} g',
                  Colors.green),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _nutrisiBox(
                  'Karbo', '${totalKarbo.toStringAsFixed(1)} g', Colors.blue),
              _nutrisiBox(
                  'Lemak', '${totalLemak.toStringAsFixed(1)} g', Colors.pink),
            ],
          ),
        ],
      ),
    );
  }

  Widget _nutrisiBox(String title, String value, Color color) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(fontSize: 14, color: Colors.black54)),
          const SizedBox(height: 4),
          Text(value,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}
