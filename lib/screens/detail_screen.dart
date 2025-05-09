// import 'package:flutter/material.dart';
// import '../models/food.dart';
// import '../models/nutrition.dart';
// import '../widgets/nutrition_card.dart';

// class DetailScreen extends StatelessWidget {
//   final Food food;
//   final Nutrition nutrition;

//   const DetailScreen({
//     Key? key,
//     required this.food,
//     required this.nutrition,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detail Nutrisi'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Food Name and Status
//             Center(
//               child: Column(
//                 children: [
//                   Text(
//                     food.name,
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Chip(
//                     label: Text(
//                       food.isGoodForPregnancy
//                           ? 'BAIK UNTUK IBU HAMIL'
//                           : 'TIDAK DISARANKAN',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     backgroundColor:
//                         food.isGoodForPregnancy ? Colors.green : Colors.red,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),

//             // Category and Serving Info
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Kategori: ${food.category}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 Text(
//                   'Per 100 gram',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//             const Divider(height: 32),

//             // Nutrition Information
//             Text(
//               'Informasi Nutrisi',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 12),
//             NutritionCard(nutrition: nutrition),
//             const SizedBox(height: 24),

//             // Benefits Section
//             Text(
//               'Manfaat untuk Ibu Hamil',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 12),
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.blue[50],
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Text(
//                 food.benefits,
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//             const SizedBox(height: 24),

//             // Warnings Section
//             Text(
//               'Peringatan dan Tips',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 12),
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.orange[50],
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Text(
//                 food.warning,
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//             const SizedBox(height: 24),

//             // Trimester Recommendations
//             if (food.isGoodForPregnancy) ...[
//               Text(
//                 'Rekomendasi Konsumsi',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.green[50],
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildRecommendationItem('Trimester 1', '2-3 porsi/minggu'),
//                     _buildRecommendationItem('Trimester 2', '3-4 porsi/minggu'),
//                     _buildRecommendationItem('Trimester 3', '4-5 porsi/minggu'),
//                   ],
//                 ),
//               ),
//             ],
//             const SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildRecommendationItem(String trimester, String recommendation) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: Text(
//               trimester,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: Text(
//               recommendation,
//               style: TextStyle(fontSize: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
