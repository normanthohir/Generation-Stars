import 'package:flutter/material.dart';
import 'package:generation_stars/theme/colors.dart';

class SharedButtton extends StatelessWidget {
  final Widget title;
  final void Function() onPressed;
  const SharedButtton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsApp.hijau,
          foregroundColor: ColorsApp.white,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: title,
      ),
    );
  }
}
