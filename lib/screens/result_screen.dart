import 'dart:io';
import 'package:flutter/material.dart';
import 'package:generation_stars/screens/MainNavigationScreen.dart';
import 'package:generation_stars/shared/shared_CircularProgres.dart';
import 'package:generation_stars/shared/shared_appbar.dart';
import 'package:generation_stars/shared/shared_button.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart'; // Pastikan sudah import AppColors

class ResultScreen extends StatefulWidget {
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
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _isLoading = false;
  Future<void> _simpanNutrisi() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    setState(() => _isLoading = true);
    try {
      await Supabase.instance.client.from('riwayat_komsumsi').insert({
        'user_id': userId,
        'nama_makanan': widget.nutrisi?['nama'],
        'ukuran_porsi': widget.nutrisi?['jumlahpersajian'],
        'kalori': widget.nutrisi?['kalori'],
        'protein': widget.nutrisi?['protein'],
        'lemak': widget.nutrisi?['lemak'],
        'karbohidrat': widget.nutrisi?['karbohidrat'],
        'serat': widget.nutrisi?['serat'],
        'zat_besi': widget.nutrisi?['zatbesi'],
        'kalium': widget.nutrisi?['kalium'],
        'vitamin': widget.nutrisi?['vitamin'],
        'manfaat': widget.nutrisi?['manfaat'],
        'peringatan': widget.nutrisi?['peringatan'],
        // 'created_at': DateTime.now().toIso8601String(),
      });

      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(message: "Data berhasil disimpan ke riwayat!"),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainNavigationScreen(),
        ),
      );
    } catch (e) {
      print("Gagal menyimpan data: $e");
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(message: "Gagal menyimpan data"),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

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
          expandedHeight: 200,
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlexibleSpaceBar(
              background: Image.file(
                widget.image,
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
                // Label hasil klasifikasi
                // SizedBox(height: 3),
                // Text(
                //   label,
                //   style: GoogleFonts.poppins(
                //     fontSize: 24,
                //     fontWeight: FontWeight.bold,
                //     color: ColorsApp.text,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                Text(
                  '${widget.nutrisi!['nama']}',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: ColorsApp.text,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                // Informasi Gizi
                widget.nutrisi != null
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
                            SizedBox(height: 3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Ukuran Porsi",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: ColorsApp.black,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Text(
                                    "${widget.nutrisi!['jumlahpersajian']}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: ColorsApp.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            // menampilkan hasil nutrisi berdasarkan gambar yang di upload
                            _buildNutritionItem(
                                'Kalori', "${widget.nutrisi!['kalori']} kkal"),
                            _buildNutritionItem(
                                'Protein', "${widget.nutrisi!['protein']} g"),
                            _buildNutritionItem(
                                'Lemak', "${widget.nutrisi!['lemak']} g"),
                            _buildNutritionItem('Karbohidrat',
                                "${widget.nutrisi!['karbohidrat']} g"),
                            _buildNutritionItem(
                                'Serat', "${widget.nutrisi!['serat']} g"),
                            _buildNutritionItem(
                                'Zat Besi', "${widget.nutrisi!['zatbesi']} mg"),
                            _buildNutritionItem(
                                'Kalium', "${widget.nutrisi!['kalium']} µg"),
                            _buildNutritionItem(
                                'Vitamin', "${widget.nutrisi!['vitamin']}"),
                            SizedBox(height: 3),

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
                              widget.nutrisi!['manfaat'] ?? '-',
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
                              widget.nutrisi!['peringatan'] ?? '-',
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
                                Expanded(
                                  child: SharedButtton(
                                    title: _isLoading
                                        ? SharedCircularprogres()
                                        : Text(
                                            'Simpan',
                                            style: GoogleFonts.poppins(
                                              color: ColorsApp.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                    onPressed: _simpanNutrisi,
                                  ),
                                ),
                                // Tombol Tidak
                                Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: ColorsApp.hijauTua,
                                        width: 2,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 30),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Text(
                                      'Tidak',
                                      style: GoogleFonts.poppins(
                                        color: ColorsApp.hijauTua,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
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
