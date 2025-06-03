import 'package:flutter/material.dart';
import 'dart:math';

class WidgetsNutrisiMingguan extends StatefulWidget {
  final double totalKalori;
  final double totalProtein;
  final double totalKarbo;
  final double totalLemak;
  final double totalSerat;
  final double totalZatbesi;
  final double totaKlalium;

  // Constructor dengan nilai default random
  WidgetsNutrisiMingguan({
    double? totalKalori,
    double? totalProtein,
    double? totalKarbo,
    double? totalLemak,
    double? totalSerat,
    double? totalZatbesi,
    double? totaKlalium,
    super.key,
  })  : totalKalori = totalKalori ?? Random().nextDouble() * 2000 + 1000,
        totalProtein = totalProtein ?? Random().nextDouble() * 100 + 30,
        totalKarbo = totalKarbo ?? Random().nextDouble() * 300 + 100,
        totalLemak = totalLemak ?? Random().nextDouble() * 100 + 30,
        totalSerat = totalSerat ?? Random().nextDouble() * 100 + 30,
        totalZatbesi = totalZatbesi ?? Random().nextDouble() * 100 + 30,
        totaKlalium = totaKlalium ?? Random().nextDouble() * 100 + 30;

  @override
  State<WidgetsNutrisiMingguan> createState() => _WidgetsNutrisiMingguanState();
}

class _WidgetsNutrisiMingguanState extends State<WidgetsNutrisiMingguan> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _nutrisiBox('Kalori',
                '${widget.totalKalori.toStringAsFixed(0)} kcal', Colors.orange),
            _nutrisiBox('Protein',
                '${widget.totalProtein.toStringAsFixed(1)} g', Colors.green),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _nutrisiBox('Karbo', '${widget.totalKarbo.toStringAsFixed(1)} g',
                Colors.blue),
            _nutrisiBox('Lemak', '${widget.totalLemak.toStringAsFixed(1)} g',
                Colors.pink),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _nutrisiBox('Serat', '${widget.totalSerat.toStringAsFixed(1)} g',
                Colors.purpleAccent),
            _nutrisiBox('Zat Besi',
                '${widget.totalZatbesi.toStringAsFixed(1)} g', Colors.grey),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _nutrisiBox('Kalium', '${widget.totaKlalium.toStringAsFixed(1)} g',
                Colors.amber),
          ],
        ),
      ],
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
