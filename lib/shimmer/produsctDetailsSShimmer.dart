import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailsShimmer extends StatelessWidget {
  const ProductDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// ===== IMAGE SHIMMER =====
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: double.infinity,
              height: 250.h,
              color: Colors.white,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// ===== TITLE + PRICE =====
                Row(
                  children: [
                    _box(width: 150.w, height: 25.h),
                    const Spacer(),
                    _box(width: 60.w, height: 25.h),
                  ],
                ),

                SizedBox(height: 10.h),

                /// ===== STARS =====
                Row(
                  children: [
                    _circle(),
                    SizedBox(width: 8.w),
                    _box(width: 100.w, height: 15.h),
                  ],
                ),

                SizedBox(height: 15.h),

                /// ===== SHORT DESCRIPTION =====
                _box(width: double.infinity, height: 15.h),
                SizedBox(height: 6.h),
                _box(width: double.infinity, height: 15.h),
                SizedBox(height: 6.h),
                _box(width: 200.w, height: 15.h),

                SizedBox(height: 20.h),

                /// ===== SECTION TITLE =====
                _box(width: 120.w, height: 15.h),

                SizedBox(height: 10.h),

                /// ===== DESCRIPTION TEXT =====
                _box(width: double.infinity, height: 12.h),
                SizedBox(height: 6.h),
                _box(width: double.infinity, height: 12.h),
                SizedBox(height: 6.h),
                _box(width: 250.w, height: 12.h),

                SizedBox(height: 20.h),

                /// ===== KEYWORDS SHIMMER =====
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: List.generate(
                    5,
                    (index) => _pill(),
                  ),
                ),

                SizedBox(height: 20.h),

                /// ===== BENEFITS =====
                _box(width: 100.w, height: 15.h),
                SizedBox(height: 10.h),

                _box(width: double.infinity, height: 12.h),
                SizedBox(height: 6.h),
                _box(width: double.infinity, height: 12.h),
                SizedBox(height: 6.h),
                _box(width: 180.w, height: 12.h),

                SizedBox(height: 20.h),

                /// ===== QUANTITY =====
                Row(
                  children: [
                    _circle(),
                    SizedBox(width: 10.w),
                    _box(width: 30.w, height: 20.h),
                    SizedBox(width: 10.w),
                    _circle(),
                  ],
                ),

                SizedBox(height: 25.h),

                /// ===== BUTTON =====
                _box(
                  width: double.infinity,
                  height: 45.h,
                  radius: 30,
                ),

                SizedBox(height: 20.h),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _box({
    required double width,
    required double height,
    double radius = 8,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  Widget _circle() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: 35.w,
        height: 35.w,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _pill() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: 80.w,
        height: 30.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }
}