import 'package:flutter/material.dart';
import 'package:generation_stars/shared/shared_appbar.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailHistoryScreen extends StatelessWidget {
  final String namaMakanan;
  final String ukuranPorsi;
  final double kalori;
  final double protein;
  final double karbo;
  final double lemak;
  final double serat;
  final double zat_besi;
  final double kalium;
  final String vitamin;
  final String manfaat;
  final String peringatan;

  const DetailHistoryScreen({
    super.key,
    required this.namaMakanan,
    required this.ukuranPorsi,
    required this.kalori,
    required this.protein,
    required this.karbo,
    required this.lemak,
    required this.serat,
    required this.zat_besi,
    required this.kalium,
    required this.vitamin,
    required this.manfaat,
    required this.peringatan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.white,
      appBar: SharedAppbar(title: namaMakanan, ipmlayLeadingFalse: true),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNutritionHeader(),
                  const SizedBox(height: 20),
                  _buildNutritionGrid(),
                  const SizedBox(height: 30),
                  _buildDetailSection(title: "Manfaat", content: "${manfaat}"),
                  const SizedBox(height: 20),
                  _buildDetailSection(
                    title: "Peringatan",
                    content: "${peringatan}",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nilai Gizi per Porsi",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                "$ukuranPorsi",
                style: GoogleFonts.poppins(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "$kalori kkal",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 2.6,
      crossAxisSpacing: 13,
      mainAxisSpacing: 13,
      children: [
        _buildNutritionItem(
          "Protein",
          "${protein}g",
          Icons.fitness_center,
          Colors.green,
        ),
        _buildNutritionItem(
          "Karbohidrat",
          "${karbo}g",
          Icons.grain,
          Colors.orange,
        ),
        _buildNutritionItem(
          "Lemak",
          "${lemak}g",
          Icons.water_drop,
          Colors.blue,
        ),
        _buildNutritionItem(
          "Serat",
          "${serat}g",
          Icons.forest,
          Colors.purple,
        ),
        _buildNutritionItem(
          "Zat Besi",
          "${zat_besi}mg",
          Icons.iron,
          Colors.redAccent.shade200,
        ),
        _buildNutritionItem(
          "Kalium",
          "${kalium}mg",
          Icons.ac_unit,
          Colors.cyan,
        ),
      ],
    );
  }

  Widget _buildNutritionItem(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.grey[700],
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
