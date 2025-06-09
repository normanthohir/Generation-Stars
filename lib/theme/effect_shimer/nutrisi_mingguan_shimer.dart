import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NutrisiMingguanShimer extends StatelessWidget {
  const NutrisiMingguanShimer({super.key});

  Widget shimmerBox() => Container(
        height: 75,
        width: 140,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(16),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [shimmerBox(), shimmerBox()],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [shimmerBox(), shimmerBox()],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [shimmerBox(), shimmerBox()],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [shimmerBox()],
          ),
        ],
      ),
    );
  }
}
