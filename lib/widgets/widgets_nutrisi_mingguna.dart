import 'package:flutter/material.dart';
import 'dart:math';

class WidgetsNutrisiMingguan extends StatefulWidget {
  final double totalKalori;
  final double totalProtein;
  final double totalKarbo;
  final double totalLemak;
  final double totalSerat;
  final double totalZatbesi;
  final double totaKlalium;

  // Constructor dengan nilai default random
  WidgetsNutrisiMingguan({
    double? totalKalori,
    double? totalProtein,
    double? totalKarbo,
    double? totalLemak,
    double? totalSerat,
    double? totalZatbesi,
    double? totaKlalium,
    super.key,
  })  : totalKalori = totalKalori ?? Random().nextDouble() * 2000 + 1000,
        totalProtein = totalProtein ?? Random().nextDouble() * 100 + 30,
        totalKarbo = totalKarbo ?? Random().nextDouble() * 300 + 100,
        totalLemak = totalLemak ?? Random().nextDouble() * 100 + 30,
        totalSerat = totalSerat ?? Random().nextDouble() * 100 + 30,
        totalZatbesi = totalZatbesi ?? Random().nextDouble() * 100 + 30,
        totaKlalium = totaKlalium ?? Random().nextDouble() * 100 + 30;

  @override
  State<WidgetsNutrisiMingguan> createState() => _WidgetsNutrisiMingguanState();
}

class _WidgetsNutrisiMingguanState extends State<WidgetsNutrisiMingguan> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _nutrisiBox('Kalori',
                '${widget.totalKalori.toStringAsFixed(0)} kcal', Colors.orange),
            _nutrisiBox('Protein',
                '${widget.totalProtein.toStringAsFixed(1)} g', Colors.green),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _nutrisiBox('Karbo', '${widget.totalKarbo.toStringAsFixed(1)} g',
                Colors.blue),
            _nutrisiBox('Lemak', '${widget.totalLemak.toStringAsFixed(1)} g',
                Colors.pink),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _nutrisiBox('Serat', '${widget.totalSerat.toStringAsFixed(1)} g',
                Colors.purpleAccent),
            _nutrisiBox('Zat Besi',
                '${widget.totalZatbesi.toStringAsFixed(1)} g', Colors.grey),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _nutrisiBox('Kalium', '${widget.totaKlalium.toStringAsFixed(1)} g',
                Colors.amber),
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
          Text(title, style: TextStyle(fontSize: 14, color: Colors.black54)),
          const SizedBox(height: 4),
          Text(value,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:intl/intl.dart';

// class NutrisiMingguanPage extends StatefulWidget {
//   final DateTime tanggalKehamilan; // dari profil user

//   const NutrisiMingguanPage({super.key, required this.tanggalKehamilan});

//   @override
//   State<NutrisiMingguanPage> createState() => _NutrisiMingguanPageState();
// }

// class _NutrisiMingguanPageState extends State<NutrisiMingguanPage> {
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
//     fetchDataMingguan();
//   }

//   Future<void> fetchDataMingguan() async {
//     final supabase = Supabase.instance.client;

//     // Hitung usia kehamilan
//     final today = DateTime.now();
//     final duration = today.difference(widget.tanggalKehamilan);
//     final currentWeek = (duration.inDays / 7).floor();

//     // Hitung tanggal minggu ini
//     final startOfWeek =
//         widget.tanggalKehamilan.add(Duration(days: (currentWeek - 1) * 7));
//     final endOfWeek =
//         widget.tanggalKehamilan.add(Duration(days: currentWeek * 7 - 1));

//     final response = await supabase
//         .from('riwayat_konsumsi')
//         .select()
//         .gte('tanggal', DateFormat('yyyy-MM-dd').format(startOfWeek))
//         .lte('tanggal', DateFormat('yyyy-MM-dd').format(endOfWeek));

//     final data = response as List<dynamic>;

//     // Akumulasi
//     for (var item in data) {
//       totalKalori += (item['kalori'] ?? 0).toDouble();
//       totalProtein += (item['protein'] ?? 0).toDouble();
//       totalKarbo += (item['karbo'] ?? 0).toDouble();
//       totalLemak += (item['lemak'] ?? 0).toDouble();
//       totalSerat += (item['serat'] ?? 0).toDouble();
//       totalZatBesi += (item['zat_besi'] ?? 0).toDouble();
//       totalKalium += (item['kalium'] ?? 0).toDouble();
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return isLoading
//         ? const Center(child: CircularProgressIndicator())
//         : Column(
//             children: [
//               const SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   _nutrisiBox('Kalori',
//                       '${totalKalori.toStringAsFixed(0)} kcal', Colors.orange),
//                   _nutrisiBox('Protein', '${totalProtein.toStringAsFixed(1)} g',
//                       Colors.green),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   _nutrisiBox('Karbo', '${totalKarbo.toStringAsFixed(1)} g',
//                       Colors.blue),
//                   _nutrisiBox('Lemak', '${totalLemak.toStringAsFixed(1)} g',
//                       Colors.pink),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   _nutrisiBox('Serat', '${totalSerat.toStringAsFixed(1)} g',
//                       Colors.purpleAccent),
//                   _nutrisiBox('Zat Besi',
//                       '${totalZatBesi.toStringAsFixed(1)} g', Colors.grey),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   // _nutrisiBox('Kalium', '${widget.totaKlalium.toStringAsFixed(1)} g',
//                   //     Colors.amber),
//                   _nutrisiBox('Kalium', '${totalKalium.toStringAsFixed(1)} g',
//                       Colors.amber),
//                 ],
//               ),
//             ],
//           );
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
//           Text(title, style: TextStyle(fontSize: 14, color: Colors.black54)),
//           const SizedBox(height: 4),
//           Text(value,
//               style: TextStyle(
//                   fontSize: 18, fontWeight: FontWeight.bold, color: color)),
//         ],
//       ),
//     );
//   }
// }
