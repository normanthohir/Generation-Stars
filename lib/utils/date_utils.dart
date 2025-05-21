import 'package:flutter/material.dart';
import 'package:generation_stars/theme/colors.dart';

class DateUtils {
  static Future<DateTime?> selectDate({
    required BuildContext context,
    required DateTime initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    String? fieldName,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      locale: Locale('id'),
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime.now(),
      helpText: fieldName ?? 'Pilih Tanggal',
      cancelText: 'Batal',
      confirmText: 'Pilih',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorsApp.hijau,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    return picked;
  }
}
