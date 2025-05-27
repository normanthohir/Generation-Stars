import 'dart:io';
import 'package:flutter/material.dart';
import 'package:generation_stars/shared/shared_appbar.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart'; // Pastikan sudah import AppColors

class ResultScreen extends StatelessWidget {
  final File image;
  final String label;
  final Map<String, dynamic>? nutrisi;

  ResultScreen({
    Key? key,
    required this.image,
    required this.label,
    required this.nutrisi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.white,
      appBar: SharedAppbar(
        title: 'Hasil Klasifikasi',
        ipmlayLeadingFalse: true,
      ),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorsApp.white,
          expandedHeight: 300,
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlexibleSpaceBar(
              background: Image.file(
                image,
                height: 200,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Gambar yang diklasifikasi
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 20),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(16),
                //       color: ColorsApp.pink,
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.black.withOpacity(0.05),
                //           blurRadius: 10,
                //           offset: Offset(0, 4),
                //         ),
                //       ],
                //     ),
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(16),
                //       child: Image.file(image, height: 250, fit: BoxFit.cover),
                //     ),
                //   ),
                // ),
                // SizedBox(height: 20),

                // Label hasil klasifikasi
                SizedBox(height: 10),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorsApp.text,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                // Informasi Gizi
                nutrisi != null
                    ? Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          // border: Border.all(color: ColorsApp.hijau.withOpacity(0.6)),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: ColorsApp.hijau.withOpacity(0.2),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Informasi Gizi",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ColorsApp.black,
                              ),
                            ),
                            SizedBox(height: 16),
                            // menampilkan hasil nutrisi berdasarkan gambar yang di upload
                            _buildNutritionItem(
                                'Kalori', "${nutrisi!['kalori']} kkal"),
                            _buildNutritionItem(
                                'Protein', "${nutrisi!['protein']} g"),
                            _buildNutritionItem(
                                'Lemak', "${nutrisi!['lemak']} g"),
                            _buildNutritionItem(
                                'Karbohidrat', "${nutrisi!['karbohidrat']} g"),
                            _buildNutritionItem(
                                'Serat', "${nutrisi!['serat']} g"),
                            _buildNutritionItem(
                                'Zat Besi', "${nutrisi!['zat_besi']} mg"),
                            _buildNutritionItem(
                                'Asam Folat', "${nutrisi!['asam_folat']} µg"),
                            _buildNutritionItem(
                                'Kalsium', "${nutrisi!['kalsium']} mg"),
                            SizedBox(height: 16),

                            // Manfaat dan Peringatan
                            Text(
                              "Manfaat",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              nutrisi!['manfaat'] ?? '-',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: ColorsApp.black,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Peringatan",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red[700],
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              nutrisi!['peringatan'] ?? '-',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: ColorsApp.black,
                              ),
                            ),
                            // Tambahkan di bagian bawah informasi gizi
                            SizedBox(height: 30),

                            // Tombol Simpan dan Tidak
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Tombol Simpan
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorsApp.hijau,
                                    foregroundColor: ColorsApp.white,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    // TODO: Aksi simpan ke riwayat
                                  },
                                  child: Text(
                                    'Simpan',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),

                                // Tombol Tidak
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: ColorsApp.black,
                                      width: 2,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    'Tidak',
                                    style: GoogleFonts.poppins(
                                      color: ColorsApp.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      )
                    : Center(
                        child: Text(
                          "Informasi gizi tidak ditemukan.",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: AppColors.subtext,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  // widget untuk menampilkan hasil nutrisi
  Widget _buildNutritionItem(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(Icons.check_circle, size: 22, color: ColorsApp.hijau),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "$title: $value",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: ColorsApp.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
