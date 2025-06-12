import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:generation_stars/shared/shared_appbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import 'package:generation_stars/theme/colors.dart';

class TrimesterScreen extends StatefulWidget {
  TrimesterScreen({Key? key}) : super(key: key);

  @override
  State<TrimesterScreen> createState() => _TrimesterScreenState();
}

class _TrimesterScreenState extends State<TrimesterScreen> {
  final supabase = Supabase.instance.client;
  int selectedNutrient = 0;
  bool isLoading = true;
  List<Map<String, dynamic>> consumptionHistory = [];

  final List<String> nutrients = [
    'Kalori',
    'Protein',
    'Lemak',
    'Karbohidrat',
    'Serat',
    'Zat Besi',
    'Kalium'
  ];

  @override
  void initState() {
    super.initState();
    _fetchConsumptionData();
  }

  Future<void> _fetchConsumptionData() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return;

      final response = await supabase
          .from('riwayat_komsumsi')
          .select()
          .eq('user_id', user.id)
          .order('created_at', ascending: false); // Urutkan dari yang terbaru

      setState(() {
        consumptionHistory = List<Map<String, dynamic>>.from(response);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat data: ${e.toString()}')),
      );
    }
  }

  Map<String, double> _getLastFourMonthsData() {
    final now = DateTime.now();
    final result = <String, double>{};

    // Inisialisasi 4 bulan terakhir
    for (int i = 0; i < 4; i++) {
      final month = DateTime(now.year, now.month - i);
      final monthKey = DateFormat('MMM').format(month);
      result[monthKey] = 0.0;
    }

    // Hitung total nutrisi per bulan
    for (var record in consumptionHistory) {
      final date = DateTime.parse(record['created_at']).toLocal();
      final monthKey = DateFormat('MMM').format(date);

      // Hanya proses data dari 4 bulan terakhir
      if (result.containsKey(monthKey)) {
        final nutrientKey = nutrients[selectedNutrient].toLowerCase();
        final value = (record[nutrientKey] ?? 0).toDouble();
        result[monthKey] = result[monthKey]! + value;
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final monthlyData = _getLastFourMonthsData();
    final months = monthlyData.keys
        .toList()
        .reversed
        .toList(); // Urutkan dari terlama ke terbaru
    final values = monthlyData.values.toList().reversed.toList();
    final currentNutrient = nutrients[selectedNutrient];

    return Scaffold(
      backgroundColor: ColorsApp.white,
      appBar: SharedAppbar(title: 'Perkembangan Nutrisi'),
      body: LayoutBuilder(
        builder: (context, raints) {
          final isSmallScreen = raints.maxWidth < 600;
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
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : consumptionHistory.isEmpty
                    ? Center(
                        child: Text('Belum ada data konsumsi',
                            style: GoogleFonts.poppins(color: Colors.grey)))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Header with dropdown
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Perkembangan Nutrisi',
                                  style: GoogleFonts.poppins(
                                    fontSize: isSmallScreen ? 14 : 18,
                                    fontWeight: FontWeight.bold,
                                    color: ColorsApp.hijauTua,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          ColorsApp.hijauTua.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: DropdownButton<int>(
                                  value: selectedNutrient,
                                  underline: SizedBox(),
                                  icon: Icon(Icons.arrow_drop_down,
                                      color: ColorsApp.hijauTua),
                                  isDense: true,
                                  items:
                                      List.generate(nutrients.length, (index) {
                                    return DropdownMenuItem<int>(
                                      value: index,
                                      child: Text(
                                        nutrients[index],
                                        style: GoogleFonts.poppins(
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
                            style: GoogleFonts.poppins(
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
                                  horizontalInterval: _getInterval(values),
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
                                      getTitlesWidget:
                                          (double value, TitleMeta meta) {
                                        final index = value.toInt();
                                        if (index >= 0 &&
                                            index < months.length) {
                                          return Padding(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              months[index],
                                              style: GoogleFonts.poppins(
                                                fontSize:
                                                    isSmallScreen ? 10 : 12,
                                                color: Colors.grey[600],
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          );
                                        }
                                        return SizedBox();
                                      },
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      interval: _getInterval(values),
                                      reservedSize: isSmallScreen ? 36 : 42,
                                      getTitlesWidget:
                                          (double value, TitleMeta meta) {
                                        return Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Text(
                                            value.toInt().toString(),
                                            style: GoogleFonts.poppins(
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
                                borderData: FlBorderData(show: false),
                                minX: 0,
                                maxX: months.length > 0 ? months.length - 1 : 3,
                                minY: 0,
                                maxY: _getMaxY(values),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots:
                                        List.generate(months.length, (index) {
                                      return FlSpot(
                                          index.toDouble(), values[index]);
                                    }),
                                    isCurved: true,
                                    curveSmoothness: 0.3,
                                    color: ColorsApp.hijauTua,
                                    barWidth: 3,
                                    isStrokeCapRound: true,
                                    dotData: FlDotData(
                                      show: true,
                                      getDotPainter:
                                          (spot, percent, barData, index) {
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
                                      color:
                                          ColorsApp.hijauTua.withOpacity(0.2),
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
                                    getTooltipItems:
                                        (List<LineBarSpot> touchedSpots) {
                                      return touchedSpots.map((spot) {
                                        final index = spot.x.toInt();
                                        return LineTooltipItem(
                                          '${months[index]}\n${spot.y.toInt()}',
                                          GoogleFonts.poppins(
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
      ),
    );
  }

  double _getMaxY(List<double> values) {
    if (values.isEmpty) return 100;
    final maxVal = values.reduce((a, b) => a > b ? a : b);
    return maxVal * 1.2; // Tambahkan 20% ruang di atas nilai maks
  }

  double _getInterval(List<double> values) {
    final maxY = _getMaxY(values);
    if (maxY <= 100) return 20;
    if (maxY <= 500) return 100;
    if (maxY <= 1000) return 200;
    if (maxY <= 2000) return 500;
    return 1000;
  }
}
