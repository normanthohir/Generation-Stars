import 'package:flutter/material.dart';
import 'package:generation_stars/utils/colors.dart';

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
          backgroundColor: AppColors.buttonText,
          foregroundColor: Color(0xFFF1EFEC),
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: title,
      ),
    );
  }
}
