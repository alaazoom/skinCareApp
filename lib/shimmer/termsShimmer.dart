import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TermsShimmer extends StatelessWidget {
  const TermsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(12),
            height: 20,
            color: Colors.white,
          );
        },
      ),
    );
  }
}