import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NutrisiMingguanShimer extends StatelessWidget {
  const NutrisiMingguanShimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          const SizedBox(height: 18),
          shimmerBoxHeader(),
          const SizedBox(height: 15),
          _buildShimerbox(),
        ],
      ),
    );
  }
}

Widget _buildShimerbox() {
  return GridView.count(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisCount: 2,
    childAspectRatio: 2.5,
    crossAxisSpacing: 14,
    mainAxisSpacing: 14,
    children: [
      _shimmerBox(),
      _shimmerBox(),
      _shimmerBox(),
      _shimmerBox(),
      _shimmerBox(),
      _shimmerBox(),
    ],
  );
}

Widget _shimmerBox() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(12),
    ),
  );
}

Widget shimmerBoxHeader() {
  return Container(
    height: 55,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(12),
    ),
  );
}
