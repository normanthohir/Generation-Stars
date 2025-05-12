import 'package:flutter/material.dart';
import 'package:generation_stars/theme/colors.dart';

class WidgetBackground extends StatelessWidget {
  const WidgetBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: -20,
          right: -20,
          child: Container(
            width: double.infinity,
            height: 260,
            decoration: BoxDecoration(
              color: ColorsApp.hijau.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(350),
                bottomRight: Radius.circular(350),
              ),
            ),
          ),
        ),
        Positioned(
          right: -0,
          child: Container(
            width: 190,
            height: 220,
            decoration: BoxDecoration(
              color: ColorsApp.hijau.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(300),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          bottom: -0,
          right: 300,
          child: Container(
            width: 150,
            height: 100,
            decoration: BoxDecoration(
              color: ColorsApp.hijau.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(200),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
