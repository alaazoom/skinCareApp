import 'package:ecommere2/ui/widgets/normalText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Mybutton extends StatelessWidget {
  final String text;
  final double h;
  final double s;
  const Mybutton({super.key, required this.text,  this.h = 40,  this.s = 24});

  @override
  Widget build(BuildContext context) {
    return   Container(
                height: h.h,width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff5C6B4A),
                  borderRadius: BorderRadius.circular(3333333333333),
                ),
                child: Center(
                  child: MyText2(text: text, size: s.sp, thisfontWeight: FontWeight.w400,
                   textColor: Color(0xffFFFFFF)),
                ),
               );
  }
}