// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:generation_stars/theme/colors.dart';

// class NutrisiChartWidget extends StatefulWidget {
//   NutrisiChartWidget({Key? key}) : super(key: key);

//   @override
//   State<NutrisiChartWidget> createState() => _NutrisiChartWidgetState();
// }

// // di ganti dengan diagram chart

// class _NutrisiChartWidgetState extends State<NutrisiChartWidget> {
//   String selectedTrimester = 'Trimester 1';

//   final Map<String, Map<String, double>> nutrisiData = {
//     'Trimester 1': {
//       'Kalori': 800,
//       'Protein': 60,
//       'Lemak': 50,
//       'Karbohidrat': 200,
//       'Serat': 25,
//       'Zat Besi': 18,
//       'Kalium': 400,
//     },
//     'Trimester 2': {
//       'Kalori': 2200,
//       'Protein': 75,
//       'Lemak': 70,
//       'Karbohidrat': 250,
//       'Serat': 30,
//       'Zat Besi': 27,
//       'Kalium': 1200,
//     },
//     'Trimester 3': {
//       'Kalori': 2400,
//       'Protein': 85,
//       'Lemak': 80,
//       'Karbohidrat': 270,
//       'Serat': 35,
//       'Zat Besi': 30,
//       'Kalium': 1300,
//     },
//   };

//   @override
//   Widget build(BuildContext context) {
//     final currentData = nutrisiData[selectedTrimester]!;

//     return SingleChildScrollView(
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Dropdown Pilih Trimester
//             DropdownButton<String>(
//               value: selectedTrimester,
//               items: nutrisiData.keys.map((String trimester) {
//                 return DropdownMenuItem<String>(
//                   value: trimester,
//                   child: Text(
//                     trimester,
//                     style: TextStyle(color: ColorsApp.hijauTua),
//                   ),
//                 );
//               }).toList(),
//               onChanged: (String? newValue) {
//                 setState(() {
//                   selectedTrimester = newValue!;
//                 });
//               },
//             ),

//             // Chart
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Container(
//                 height: 330,
//                 child: BarChart(
//                   BarChartData(
//                     alignment: BarChartAlignment.spaceAround,
//                     maxY: _getMaxY(currentData.values),
//                     barTouchData: BarTouchData(enabled: true),
//                     titlesData: FlTitlesData(
//                       leftTitles: AxisTitles(
//                         sideTitles: SideTitles(
//                           showTitles: true,
//                         ),
//                       ),
//                       bottomTitles: AxisTitles(
//                         sideTitles: SideTitles(
//                           showTitles: true,
//                           getTitlesWidget: (double value, TitleMeta meta) {
//                             return SideTitleWidget(
//                               axisSide: meta.axisSide,
//                               child: Transform.rotate(
//                                 angle:
//                                     45 * 3.1415927 / 180, // Rotate 45 degrees
//                                 child: Text(
//                                   currentData.keys.elementAt(value.toInt()),
//                                   style: TextStyle(
//                                     fontSize: 10,
//                                     color: ColorsApp.hijauTua,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                     borderData: FlBorderData(show: false),
//                     barGroups: List.generate(currentData.length, (index) {
//                       return BarChartGroupData(
//                         x: index,
//                         barRods: [
//                           BarChartRodData(
//                             toY: currentData.values.elementAt(index),
//                             color: ColorsApp.hijauTua,
//                             width: 16,
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                         ],
//                       );
//                     }),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   double _getMaxY(Iterable<double> values) {
//     final maxVal = values.reduce((a, b) => a > b ? a : b);
//     return maxVal + (maxVal * 0.2); // Add 20% space above the max value
//   }
// }

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:generation_stars/theme/colors.dart';

class NutrisiChartWidget extends StatefulWidget {
  const NutrisiChartWidget({Key? key}) : super(key: key);

  @override
  State<NutrisiChartWidget> createState() => _NutrisiChartWidgetState();
}

class _NutrisiChartWidgetState extends State<NutrisiChartWidget> {
  int selectedNutrient = 0;
  final List<String> nutrients = [
    'Kalori',
    'Protein',
    'Lemak',
    'Karbohidrat',
    'Serat',
    'Zat Besi',
    'Kalium'
  ];

  // Month names (adjust based on your starting month)
  final List<String> months = ['Jan', 'Feb', 'Mar', 'Apr'];

  // Data per bulan (4 bulan) untuk setiap nutrisi
  final Map<String, List<double>> monthlyNutrientData = {
    'Kalori': [1800, 2000, 2200, 2400],
    'Protein': [60, 70, 75, 85],
    'Lemak': [50, 60, 70, 80],
    'Karbohidrat': [200, 220, 250, 270],
    'Serat': [25, 28, 30, 35],
    'Zat Besi': [18, 22, 27, 30],
    'Kalium': [400, 800, 1200, 1300],
  };

  @override
  Widget build(BuildContext context) {
    final currentNutrient = nutrients[selectedNutrient];
    final monthlyData = monthlyNutrientData[currentNutrient]!;
    final maxY = _getMaxY(monthlyData);
    final interval = _getInterval(maxY);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          margin: EdgeInsets.all(isSmallScreen ? 8 : 16),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header with dropdown
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Perkembangan Nutrisi',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 16 : 18,
                        fontWeight: FontWeight.bold,
                        color: ColorsApp.hijauTua,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorsApp.hijauTua.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButton<int>(
                      value: selectedNutrient,
                      underline: SizedBox(),
                      icon: Icon(Icons.arrow_drop_down,
                          color: ColorsApp.hijauTua),
                      isDense: true,
                      items: List.generate(nutrients.length, (index) {
                        return DropdownMenuItem<int>(
                          value: index,
                          child: Text(
                            nutrients[index],
                            style: TextStyle(
                              fontSize: isSmallScreen ? 12 : 14,
                              color: ColorsApp.hijauTua,
                            ),
                          ),
                        );
                      }),
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedNutrient = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                currentNutrient,
                style: TextStyle(
                  fontSize: isSmallScreen ? 12 : 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 16),

              // Responsive chart container
              AspectRatio(
                aspectRatio: isSmallScreen ? 1.2 : 1.8,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      horizontalInterval: interval,
                      verticalInterval: 1,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.grey.withOpacity(0.15),
                          strokeWidth: 1,
                        );
                      },
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: Colors.grey.withOpacity(0.15),
                          strokeWidth: 1,
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 22,
                          interval: 1,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                months[value.toInt()],
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 10 : 12,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: interval,
                          reservedSize: isSmallScreen ? 36 : 42,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                value.toInt().toString(),
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 10 : 12,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    minX: 0,
                    maxX: monthlyData.length.toDouble() - 1,
                    minY: 0,
                    maxY: maxY,
                    lineBarsData: [
                      LineChartBarData(
                        spots: List.generate(monthlyData.length, (index) {
                          return FlSpot(index.toDouble(), monthlyData[index]);
                        }),
                        isCurved: true,
                        curveSmoothness: 0.3,
                        color: ColorsApp.hijauTua,
                        barWidth: 3,
                        isStrokeCapRound: true,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) {
                            return FlDotCirclePainter(
                              radius: 4,
                              color: Colors.white,
                              strokeWidth: 2,
                              strokeColor: ColorsApp.hijauTua,
                            );
                          },
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              ColorsApp.hijauTua.withOpacity(0.3),
                              ColorsApp.hijauTua.withOpacity(0.1),
                            ],
                          ),
                        ),
                        shadow: BoxShadow(
                          color: ColorsApp.hijauTua.withOpacity(0.2),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ),
                    ],
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        tooltipBgColor: Colors.white,
                        tooltipBorder: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1,
                        ),
                        getTooltipItems: (List<LineBarSpot> touchedSpots) {
                          return touchedSpots.map((spot) {
                            return LineTooltipItem(
                              '${spot.y.toInt()}',
                              TextStyle(
                                color: ColorsApp.hijauTua,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  double _getMaxY(List<double> values) {
    final maxVal = values.reduce((a, b) => a > b ? a : b);
    return maxVal * 1.2; // Add 20% space above the max value
  }

  double _getInterval(double maxY) {
    if (maxY <= 100) return 20;
    if (maxY <= 500) return 100;
    if (maxY <= 1000) return 200;
    if (maxY <= 2000) return 500;
    return 1000;
  }
}
