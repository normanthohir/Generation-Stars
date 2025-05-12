import 'dart:io';
import 'package:flutter/material.dart';
import 'package:generation_stars/theme/colors.dart'; // Pastikan sudah import AppColors

class ResultScreen extends StatelessWidget {
  final File image;
  final String label;
  final Map<String, dynamic>? nutrisi;

  const ResultScreen({
    Key? key,
    required this.image,
    required this.label,
    required this.nutrisi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Hasil Klasifikasi",
          style: TextStyle(
            color: AppColors.heading,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        iconTheme: IconThemeData(color: AppColors.heading),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Gambar yang diklasifikasi
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(image, height: 250, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 20),

            // Label hasil klasifikasi
            Text(
              label,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.heading,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),

            // Informasi Gizi
            nutrisi != null
                ? Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
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
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.heading,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildNutritionItem(
                            'Kalori', "${nutrisi!['kalori']} kkal"),
                        _buildNutritionItem(
                            'Protein', "${nutrisi!['protein']} g"),
                        _buildNutritionItem('Lemak', "${nutrisi!['lemak']} g"),
                        _buildNutritionItem(
                            'Karbohidrat', "${nutrisi!['karbohidrat']} g"),
                        _buildNutritionItem('Serat', "${nutrisi!['serat']} g"),
                        _buildNutritionItem(
                            'Zat Besi', "${nutrisi!['zat_besi']} mg"),
                        _buildNutritionItem(
                            'Asam Folat', "${nutrisi!['asam_folat']} µg"),
                        _buildNutritionItem(
                            'Kalsium', "${nutrisi!['kalsium']} mg"),
                        const SizedBox(height: 16),

                        // Manfaat dan Peringatan
                        Text(
                          "✅ Manfaat",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          nutrisi!['manfaat'] ?? '-',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.subtext,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "⚠️ Peringatan",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[700],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          nutrisi!['peringatan'] ?? '-',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.subtext,
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
                                backgroundColor: AppColors.button,
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
                                style: TextStyle(
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
                                    color: AppColors.buttonBorder, width: 2),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                // TODO: Aksi kembali ke home
                              },
                              child: Text(
                                'Tidak',
                                style: TextStyle(
                                  color: AppColors.button,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  )
                : Center(
                    child: Text(
                      "Informasi gizi tidak ditemukan.",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.subtext,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(Icons.check_circle, size: 20, color: AppColors.button),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "$title: $value",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.subtext,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
