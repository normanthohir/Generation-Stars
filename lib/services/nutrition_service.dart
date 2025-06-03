import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class NutritionService {
  static Future<Map<String, dynamic>?> loadNutrisi(String label) async {
    final rawData =
        await rootBundle.loadString('assets/data/food_nutrition.csv');
    List<List<dynamic>> listData =
        const CsvToListConverter(fieldDelimiter: ';').convert(rawData);

    final headers = listData.first;
    final rows = listData.sublist(1);

    final data = rows.map((row) {
      final map = Map.fromIterables(headers, row);
      return map.map((key, value) => MapEntry(key.toString(), value));
    }).toList();

    final cleanedLabel = label.toLowerCase().trim();

    // Debug: lihat apa yang sedang dicocokkan
    print("🔍 Mencari label: '$cleanedLabel'");

    final match = data.firstWhere(
      (item) => item['label'].toString().toLowerCase().trim() == cleanedLabel,
      orElse: () => {},
    );

    print("📋 Match ditemukan: $match");

    return match.isNotEmpty ? match : null;
  }
}
