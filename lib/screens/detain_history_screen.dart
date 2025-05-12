import 'package:flutter/material.dart';
import 'package:generation_stars/shared/shared_appbar.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailHistoryScreen extends StatelessWidget {
  final String foodName;
  final String foodImage;
  final int calories;
  final double protein;
  final double carbs;
  final double fat;
  final String description;

  const DetailHistoryScreen({
    super.key,
    required this.foodName,
    required this.foodImage,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: SharedAppbar(title: foodName, ipmlayLeadingFalse: true),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  _buildNutritionHeader(),
                  const SizedBox(height: 20),
                  _buildNutritionGrid(),
                  const SizedBox(height: 30),
                  _buildDetailSection(
                    title: "Manfaat",
                    content:
                        "Makanan ini kaya akan protein yang baik untuk perkembangan janin dan asam lemak omega-3 yang mendukung perkembangan otak bayi.",
                  ),
                  const SizedBox(height: 20),
                  _buildDetailSection(
                    title: "Peringatan",
                    content:
                        "Sajikan dengan sayuran hijau untuk meningkatkan penyerapan zat besi. Hindari memasak terlalu lama untuk mempertahankan nutrisi.",
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
                "Ukuran porsi: 100 gram",
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
              "$calories kkal",
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
      childAspectRatio: 3,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        _buildNutritionItem(
          "Protein",
          "${protein}g",
          "Membangun jaringan janin",
          Icons.fitness_center,
          Colors.green,
        ),
        _buildNutritionItem(
          "Karbohidrat",
          "${carbs}g",
          "Sumber energi",
          Icons.grain,
          Colors.orange,
        ),
        _buildNutritionItem(
          "Lemak",
          "${fat}g",
          "Perkembangan otak",
          Icons.water_drop,
          Colors.blue,
        ),
        _buildNutritionItem(
          "Serat",
          "3.5g",
          "Pencernaan sehat",
          Icons.forest,
          Colors.purple,
        ),
      ],
    );
  }

  Widget _buildNutritionItem(
      String title, String value, String subtitle, IconData icon, Color color) {
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
