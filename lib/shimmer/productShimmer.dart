// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';

// class ProductShimmer extends StatelessWidget {
//   const ProductShimmer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
// physics: NeverScrollableScrollPhysics(),
//       itemCount: 6,
//       itemBuilder: (context, index) {
//         return Shimmer.fromColors(
//           baseColor: Colors.grey[300]!,
//           highlightColor: Colors.grey[100]!,
//           child: Container(
//             margin: EdgeInsets.all(10),
//             height: 100,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 14.w,
        childAspectRatio: 0.57,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        );
      },
    );
  }
}