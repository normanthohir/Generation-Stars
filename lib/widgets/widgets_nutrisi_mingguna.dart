// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class WidgetsNutrisiMingguan extends StatefulWidget {
//   final String userId;
//   final String tanggalKehamilan;

//   const WidgetsNutrisiMingguan({
//     super.key,
//     required this.userId,
//     required this.tanggalKehamilan,
//   });

//   @override
//   State<WidgetsNutrisiMingguan> createState() => _WidgetsNutrisiMingguanState();
// }

// class _WidgetsNutrisiMingguanState extends State<WidgetsNutrisiMingguan> {
//   double totalKalori = 0;
//   double totalProtein = 0;
//   double totalKarbo = 0;
//   double totalLemak = 0;
//   double totalSerat = 0;
//   double totalZatBesi = 0;
//   double totalKalium = 0;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchDataNutrisi();
//   }

//   Future<void> fetchDataNutrisi() async {
//     final supabase = Supabase.instance.client;

//     final mingguKe = hitungUsiaKehamilanMinggu(widget.tanggalKehamilan);
//     final tanggalMulai = DateTime.parse(widget.tanggalKehamilan)
//         .add(Duration(days: mingguKe * 7));
//     final tanggalAkhir = tanggalMulai.add(const Duration(days: 6));

//     final response = await supabase
//         .from('riwayat_komsumsi')
//         .select()
//         .gte('created_at', tanggalMulai.toIso8601String())
//         .lte('created_at', tanggalAkhir.toIso8601String())
//         .eq('user_id', widget.userId);

//     if (response != null && response.isNotEmpty) {
//       for (var row in response) {
//         totalKalori += (row['kalori'] ?? 0).toDouble();
//         totalProtein += (row['protein'] ?? 0).toDouble();
//         totalKarbo += (row['karbo'] ?? 0).toDouble();
//         totalLemak += (row['lemak'] ?? 0).toDouble();
//         totalSerat += (row['serat'] ?? 0).toDouble();
//         totalZatBesi += (row['zat_besi'] ?? 0).toDouble();
//         totalKalium += (row['kalium'] ?? 0).toDouble();
//       }
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   int hitungUsiaKehamilanMinggu(String tanggalKehamilan) {
//     final startDate = DateTime.parse(tanggalKehamilan);
//     return DateTime.now().difference(startDate).inDays ~/ 7;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Jika masih loading atau userId / tanggal_kehamilan belum siap

//     return Column(
//       children: [
//         const SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _nutrisiBox('Kalori', '${totalKalori.toStringAsFixed(0)} kcal',
//                 Colors.orange),
//             _nutrisiBox('Protein', '${totalProtein.toStringAsFixed(1)} g',
//                 Colors.green),
//           ],
//         ),
//         const SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _nutrisiBox(
//                 'Karbo', '${totalKarbo.toStringAsFixed(1)} g', Colors.blue),
//             _nutrisiBox(
//                 'Lemak', '${totalLemak.toStringAsFixed(1)} g', Colors.pink),
//           ],
//         ),
//         const SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _nutrisiBox('Serat', '${totalSerat.toStringAsFixed(1)} g',
//                 Colors.purpleAccent),
//             _nutrisiBox('Zat Besi', '${totalZatBesi.toStringAsFixed(1)} g',
//                 Colors.grey),
//           ],
//         ),
//         const SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _nutrisiBox(
//                 'Kalium', '${totalKalium.toStringAsFixed(1)} g', Colors.amber),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _nutrisiBox(String title, String value, Color color) {
//     return Container(
//       width: 140,
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: color.withOpacity(0.4)),
//       ),
//       child: Column(
//         children: [
//           Text(title,
//               style: const TextStyle(fontSize: 14, color: Colors.black54)),
//           const SizedBox(height: 4),
//           Text(value,
//               style: TextStyle(
//                   fontSize: 18, fontWeight: FontWeight.bold, color: color)),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:generation_stars/theme/effect_shimer/nutrisi_mingguan_shimer.dart';
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
      totalKarbo += (row['karbo'] ?? 0).toDouble();
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
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _nutrisiBox('Kalori', '${totalKalori.toStringAsFixed(0)} kcal',
                Colors.orange),
            _nutrisiBox('Protein', '${totalProtein.toStringAsFixed(1)} g',
                Colors.green),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _nutrisiBox(
                'Karbo', '${totalKarbo.toStringAsFixed(1)} g', Colors.blue),
            _nutrisiBox(
                'Lemak', '${totalLemak.toStringAsFixed(1)} g', Colors.pink),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _nutrisiBox('Serat', '${totalSerat.toStringAsFixed(1)} g',
                Colors.purpleAccent),
            _nutrisiBox('Zat Besi', '${totalZatBesi.toStringAsFixed(1)} g',
                Colors.grey),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _nutrisiBox(
                'Kalium', '${totalKalium.toStringAsFixed(1)} g', Colors.amber),
          ],
        ),
      ],
    );
  }

  Widget _nutrisiBox(String title, String value, Color color) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        children: [
          Text(title,
              style: const TextStyle(fontSize: 14, color: Colors.black54)),
          const SizedBox(height: 4),
          Text(value,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}
