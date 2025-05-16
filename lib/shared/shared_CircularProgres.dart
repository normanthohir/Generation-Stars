import 'package:flutter/material.dart';
import 'package:generation_stars/theme/colors.dart';

class SharedCircularprogres extends StatelessWidget {
  const SharedCircularprogres({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 23,
      height: 23,
      child: CircularProgressIndicator(
        color: ColorsApp.white,
      ),
    );
  }
}
