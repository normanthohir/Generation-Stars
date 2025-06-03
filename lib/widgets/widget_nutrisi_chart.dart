import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:generation_stars/theme/colors.dart';

class NutrisiChartWidget extends StatefulWidget {
  NutrisiChartWidget({Key? key}) : super(key: key);

  @override
  State<NutrisiChartWidget> createState() => _NutrisiChartWidgetState();
}

class _NutrisiChartWidgetState extends State<NutrisiChartWidget> {
  String selectedTrimester = 'Trimester 1';

  final Map<String, Map<String, double>> nutrisiData = {
    'Trimester 1': {
      'Kalori': 800,
      'Protein': 60,
      'Lemak': 50,
      'Karbohidrat': 200,
      'Serat': 25,
      'Zat Besi': 18,
      'Kalium': 400,
    },
    'Trimester 2': {
      'Kalori': 2200,
      'Protein': 75,
      'Lemak': 70,
      'Karbohidrat': 250,
      'Serat': 30,
      'Zat Besi': 27,
      'Kalium': 1200,
    },
    'Trimester 3': {
      'Kalori': 2400,
      'Protein': 85,
      'Lemak': 80,
      'Karbohidrat': 270,
      'Serat': 35,
      'Zat Besi': 30,
      'Kalium': 1300,
    },
  };

  @override
  Widget build(BuildContext context) {
    final currentData = nutrisiData[selectedTrimester]!;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown Pilih Trimester
            DropdownButton<String>(
              value: selectedTrimester,
              items: nutrisiData.keys.map((String trimester) {
                return DropdownMenuItem<String>(
                  value: trimester,
                  child: Text(
                    trimester,
                    style: TextStyle(color: ColorsApp.hijauTua),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedTrimester = newValue!;
                });
              },
            ),

            // Chart
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                height: 330,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: _getMaxY(currentData.values),
                    barTouchData: BarTouchData(enabled: true),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Transform.rotate(
                                angle:
                                    45 * 3.1415927 / 180, // Rotate 45 degrees
                                child: Text(
                                  currentData.keys.elementAt(value.toInt()),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: ColorsApp.hijauTua,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: List.generate(currentData.length, (index) {
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: currentData.values.elementAt(index),
                            color: ColorsApp.hijauTua,
                            width: 16,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getMaxY(Iterable<double> values) {
    final maxVal = values.reduce((a, b) => a > b ? a : b);
    return maxVal + (maxVal * 0.2); // Add 20% space above the max value
  }
}
