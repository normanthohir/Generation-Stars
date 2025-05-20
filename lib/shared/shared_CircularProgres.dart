import 'package:flutter/material.dart';
import 'package:generation_stars/theme/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SharedCircularprogres extends StatelessWidget {
  const SharedCircularprogres({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.hexagonDots(
      color: ColorsApp.white,
      size: 23,
    );
  }
}
