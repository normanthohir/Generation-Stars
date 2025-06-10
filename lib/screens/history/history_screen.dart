import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generation_stars/screens/history/detail_history_screen.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:generation_stars/shared/shared_appbar.dart';
import 'package:generation_stars/theme/effect_shimer/riwayar_komsumsi_shimer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateTime _selectedDate = DateTime.now();
  List<Map<String, dynamic>> _historyData = [];
  bool _isLoading = true;
  final _supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _fetchHistoryData();
  }

  Future<void> _fetchHistoryData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Format tanggal untuk query (hanya tanggal tanpa waktu)
      final formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);

      final userId = _supabase.auth.currentUser?.id;

      if (userId == null) {
        throw Exception('User not logged in');
      }

      // Query data dari Supabase
      final response = await _supabase
          .from('riwayat_komsumsi')
          .select()
          .eq('user_id', userId)
          .gte('created_at', '${formattedDate}T00:00:00Z')
          .lte('created_at', '${formattedDate}T23:59:59Z')
          .order('created_at', ascending: false);

      setState(() {
        _historyData = List<Map<String, dynamic>>.from(response);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat data: ${e.toString()}')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorsApp.hijau,
              onPrimary: ColorsApp.white,
              onSurface: ColorsApp.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      _fetchHistoryData(); // Refresh data ketika tanggal berubah
    }
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.white,
      appBar: SharedAppbar(title: 'Riwayat Konsumsi'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Picker Card
            Container(
              margin: EdgeInsets.only(bottom: 20, top: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    ColorsApp.hijau.withOpacity(0.9),
                    ColorsApp.hijau.withOpacity(0.6),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                leading: Icon(
                  FontAwesomeIcons.calendarDay,
                  color: ColorsApp.white,
                  size: 28,
                ),
                title: Text(
                  'Pilih Tanggal',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: ColorsApp.white,
                  ),
                ),
                subtitle: Text(
                  DateFormat('EEEE, d MMMM y').format(_selectedDate),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: ColorsApp.white,
                  ),
                ),
                trailing: Icon(
                  FontAwesomeIcons.caretDown,
                  size: 20,
                  color: ColorsApp.white,
                ),
                onTap: () => _selectDate(context),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Container(
                width: double.infinity,
                height: 2,
                color: Colors.grey[500],
              ),
            ),

            // History List
            Expanded(
              child: _isLoading
                  ? RiwayatKonsumsiShimmer()
                  : _historyData.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.fastfood,
                                size: 60,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Tidak ada data untuk tanggal ini',
                                style: GoogleFonts.poppins(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: _historyData.length,
                          itemBuilder: (context, index) {
                            final item = _historyData[index];
                            final createdAt =
                                DateTime.parse(item['created_at'] as String);

                            return Card(
                              color: ColorsApp.white,
                              margin: EdgeInsets.only(bottom: 18),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: ColorsApp.hijau, width: 2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 12),
                                leading: CircleAvatar(
                                  backgroundColor:
                                      ColorsApp.hijau.withOpacity(0.1),
                                  child: Icon(
                                    Icons.fastfood,
                                    color: ColorsApp.hijau,
                                  ),
                                ),
                                title: Text(
                                  item['nama_makanan'] ?? 'Makanan',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Text(
                                  _formatTime(createdAt),
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color: ColorsApp.hijau,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailHistoryScreen(
                                        namaMakanan:
                                            item['nama_makanan'] ?? 'Makanan',
                                        ukuranPorsi: (item['ukuran_porsi'] ??
                                            'Tidak tau'),
                                        kalori:
                                            (item['kalori'] ?? 0).toDouble(),
                                        protein:
                                            (item['protein'] ?? 0).toDouble(),
                                        karbo: (item['karbohidrat'] ?? 0)
                                            .toDouble(),
                                        lemak: (item['lemak'] ?? 0).toDouble(),
                                        serat: (item['serat'] ?? 0).toDouble(),
                                        zat_besi:
                                            (item['zat_besi'] ?? 0).toDouble(),
                                        kalium:
                                            (item['kalium'] ?? 0).toDouble(),
                                        vitamin: item['vitamin'] ?? 'Tidak ada',
                                        manfaat: item['manfaat'] ?? 'Tidak ada',
                                        peringatan:
                                            item['peringatan'] ?? 'Tidak ada',
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
