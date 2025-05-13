import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generation_stars/screens/detain_history_screen.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:generation_stars/shared/shared_appbar.dart';
import 'package:generation_stars/widgets/widget_background.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  DateTime _selectedDate = DateTime.now();

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
              primary: ColorsApp.hijau, // Header background color
              onPrimary: ColorsApp.white, // Header text color
              onSurface: ColorsApp.black, // Body text color
            ),
            dialogBackgroundColor: Colors.white, // Background color
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

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
                // color: ColorsApp.hijau.withOpacity(0.9),
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
            // History List Placeholder
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Placeholder untuk 3 item
                itemBuilder: (context, index) {
                  return Card(
                    color: ColorsApp.white,
                    margin: EdgeInsets.only(bottom: 18),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: ColorsApp.hijau, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                      leading: CircleAvatar(
                        backgroundColor: AppColors.button.withOpacity(0.1),
                        child: Icon(
                          Icons.fastfood,
                          color: ColorsApp.hijau,
                        ),
                      ),
                      title: Text(
                        'Makanan ${index + 1}',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        '10.00 AM',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: AppColors.button,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailHistoryScreen(
                              foodName: "Salmon Panggang",
                              foodImage: "https://example.com/salmon.jpg",
                              calories: 280,
                              protein: 25.5,
                              carbs: 12.3,
                              fat: 15.8,
                              description:
                                  "Ikan salmon kaya omega-3 yang baik untuk perkembangan otak janin",
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            // Empty State (opsional, bisa dihapus jika ada data)
            // if (false) // Ubah ke true untuk melihat empty state
            //   Expanded(
            //     child: Center(
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Icon(
            //             Icons.fastfood,
            //             size: 60,
            //             color: AppColors.buttonText.withOpacity(0.5),
            //           ),
            //            SizedBox(height: 16),
            //           Text(
            //             'Tidak ada data untuk tanggal ini',
            //             style: GoogleFonts.poppins(
            //               color: Colors.grey[600],
            //               fontSize: 16,
            //               fontWeight: FontWeight.w500,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
