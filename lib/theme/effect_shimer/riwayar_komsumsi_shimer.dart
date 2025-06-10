import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RiwayatKonsumsiShimmer extends StatelessWidget {
  const RiwayatKonsumsiShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      itemCount: 5, // Jumlah placeholder shimmer
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: double.infinity,
            height: 80,
            // padding: EdgeInsets.all(12),
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            // child: Padding(
            // padding: const EdgeInsets.all(12),
            //   child: Row(
            //     children: [
            //       // Placeholder untuk ikon/gambar
            //       Container(
            //         width: 48,
            //         height: 48,
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           shape: BoxShape.circle,
            //           border: Border.all(color: Colors.grey[200]!),
            //         ),
            //       ),
            //       const SizedBox(width: 12),
            //       // Placeholder untuk teks
            //       Expanded(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Container(
            //               width: double.infinity,
            //               height: 16,
            //               decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius: BorderRadius.circular(4),
            //               ),
            //             ),
            //             const SizedBox(height: 8),
            //             Container(
            //               width: 100,
            //               height: 14,
            //               decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius: BorderRadius.circular(4),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       // Placeholder untuk ikon panah
            //       const Icon(Icons.chevron_right, color: Colors.transparent),
            //     ],
            //   ),
            // ),
          ),
        );
      },
    );
  }
}
