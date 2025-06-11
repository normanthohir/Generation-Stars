import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generation_stars/theme/effect_shimer/nutrisi_mingguan_shimer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WidgetsNutrisiMingguan extends StatefulWidget {
  const WidgetsNutrisiMingguan({super.key});

  @override
  State<WidgetsNutrisiMingguan> createState() => _WidgetsNutrisiMingguanState();
}

class _WidgetsNutrisiMingguanState extends State<WidgetsNutrisiMingguan> {
  double totalKalori = 0;
  double totalProtein = 0;
  double totalKarbo = 0;
  double totalLemak = 0;
  double totalSerat = 0;
  double totalZatBesi = 0;
  double totalKalium = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDataNutrisi();
  }

  Future<void> fetchDataNutrisi() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final userId = user.id;

    // Ambil tanggal kehamilan dari tabel profil
    final profile = await supabase
        .from('profile')
        .select('tanggal_kehamilan')
        .eq('id', userId)
        .single();

    if (profile == null || profile['tanggal_kehamilan'] == null) {
      setState(() => isLoading = false);
      return;
    }

    final tanggalKehamilan = profile['tanggal_kehamilan'];
    final mingguKe = hitungUsiaKehamilanMinggu(tanggalKehamilan);
    final tanggalMulai =
        DateTime.parse(tanggalKehamilan).add(Duration(days: mingguKe * 7));
    final tanggalAkhir = tanggalMulai.add(const Duration(days: 6));

    final konsumsi = await supabase
        .from('riwayat_komsumsi')
        .select()
        .gte('created_at', tanggalMulai.toIso8601String())
        .lte('created_at', tanggalAkhir.toIso8601String())
        .eq('user_id', userId);

    for (var row in konsumsi) {
      totalKalori += (row['kalori'] ?? 0).toDouble();
      totalProtein += (row['protein'] ?? 0).toDouble();
      totalKarbo += (row['karbohidrat'] ?? 0).toDouble();
      totalLemak += (row['lemak'] ?? 0).toDouble();
      totalSerat += (row['serat'] ?? 0).toDouble();
      totalZatBesi += (row['zat_besi'] ?? 0).toDouble();
      totalKalium += (row['kalium'] ?? 0).toDouble();
    }

    setState(() {
      isLoading = false;
    });
  }

  int hitungUsiaKehamilanMinggu(String tanggalKehamilan) {
    final startDate = DateTime.parse(tanggalKehamilan);
    return DateTime.now().difference(startDate).inDays ~/ 7;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: NutrisiMingguanShimer());
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _buildNutritionHeader(),
        const SizedBox(height: 15),
        _buildNutritionBox(),
      ],
    );
  }

  Widget _buildNutritionBox() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 2.5,
      crossAxisSpacing: 14,
      mainAxisSpacing: 14,
      children: [
        _nutrisiBox('Protein', '${totalProtein.toStringAsFixed(1)} g',
            Icons.fitness_center, Colors.green),
        _nutrisiBox('Karbohidrat', '${totalKarbo.toStringAsFixed(1)} g',
            Icons.grain, Colors.orange),
        _nutrisiBox('Lemak', '${totalLemak.toStringAsFixed(1)} g',
            Icons.water_drop, Colors.amber),
        _nutrisiBox('Serat', '${totalSerat.toStringAsFixed(1)} g',
            FontAwesomeIcons.leaf, Colors.purple),
        _nutrisiBox('Zat Besi', '${totalZatBesi.toStringAsFixed(1)} mg',
            FontAwesomeIcons.magnet, Colors.redAccent.shade200),
        _nutrisiBox('Kalium', '${totalKalium.toStringAsFixed(1)} mg',
            FontAwesomeIcons.atom, Colors.cyan),
      ],
    );
  }

  Widget _buildNutritionHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            "Kalori minggu ini",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.fire,
                  size: 24,
                  color: Colors.blue[800],
                ),
                SizedBox(width: 8),
                Text(
                  "${totalKalori.toStringAsFixed(0)} kkal",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _nutrisiBox(String title, String value, IconData icon, Color color) {
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
}
