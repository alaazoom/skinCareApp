import 'package:ecommere2/ui/screens/contactUs.dart';
import 'package:ecommere2/ui/widgets/myButton.dart';
import 'package:ecommere2/ui/widgets/myText.dart';
import 'package:ecommere2/ui/widgets/normalText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xffFAF8F5),
      appBar: AppBar(
        backgroundColor: Color(0xffFAF8F5),
        title: MyText(text: "About Us", size: 24.sp, thisfontWeight: FontWeight.w600,
         textColor: Color(0xff2C2C2C)),
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.h,),
                Container(
                  height: 170.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    color: Color(0xff5C6B4A).withOpacity(.1)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(text: "Natural\nBeauty", size: 60.sp,
                       thisfontWeight: FontWeight.w400, textColor: Color(0xff2C2C2C)),
                       SizedBox(height: 5.h,),
                        MyText2(text: "Since 2020", size: 16.sp,
                       thisfontWeight: FontWeight.w400, textColor: Color(0xff5C6B4A)),
                    ],
                  ),
                ),
                SizedBox(height: 18.h,),
                 MyText(text: "Our Story", size: 24.sp, thisfontWeight: FontWeight.w600,
             textColor: Color(0xff2C2C2C)),
                SizedBox(height: 10.h,),
                 MyText2(text: "We believe in the power of nature to transform your skin. Our products are carefully crafted using the finest natural ingredients, sourced sustainably from around the world.", size: 16.sp, thisfontWeight: FontWeight.w400,
             textColor: Color(0xff2C2C2C),textAlign: TextAlign.start,),
                SizedBox(height: 10.h,),
                 MyText2(text: "Each formula is developed with care, combining traditional wisdom with modern science to deliver exceptional results while being gentle on your skin and the planet.", size: 16.sp, thisfontWeight: FontWeight.w400,
             textColor: Color(0xff2C2C2C),textAlign: TextAlign.start,),
              SizedBox(height: 24.h,),
                 MyText(text: "Our Values", size: 24.sp, thisfontWeight: FontWeight.w600,
             textColor: Color(0xff2C2C2C)),
             SizedBox(height: 10.h,),
             Container(
              height: 100.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Center(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText2(text: "🌿 Natural Ingredients", size: 20.sp, thisfontWeight: FontWeight.w500,
                       textColor: Color(0xff2C2C2C)),
                       SizedBox(height: 4.h,),
                      MyText2(text: "We use only the highest quality natural and organic ingredients in all our formulations.", size: 15.sp, thisfontWeight: FontWeight.w400,
                       textColor: Color(0xff8B8B8B),textAlign: TextAlign.start,),
                    ],
                  ),
                ),
              ),
             ),
             SizedBox(height: 10.h,),
             Container(
              height: 100.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Center(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText2(text: "🐰 Cruelty-Free", size: 20.sp, thisfontWeight: FontWeight.w500,
                       textColor: Color(0xff2C2C2C)),
                       SizedBox(height: 4.h,),
                      MyText2(text: "All our products are cruelty-free and never tested on animals.", size: 15.sp, thisfontWeight: FontWeight.w400,
                       textColor: Color(0xff8B8B8B),textAlign: TextAlign.start,),
                    ],
                  ),
                ),
              ),
             ),
             SizedBox(height: 10.h,),
            
             Container(
              height: 100.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Center(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText2(text: "♻️ Sustainable", size: 20.sp, thisfontWeight: FontWeight.w500,
                       textColor: Color(0xff2C2C2C)),
                       SizedBox(height: 4.h,),
                      MyText2(text: "We're committed to sustainable practices and eco-friendly packaging.", size: 15.sp, thisfontWeight: FontWeight.w400,
                       textColor: Color(0xff8B8B8B),textAlign: TextAlign.start,),
                    ],
                  ),
                ),
              ),
             ),
             SizedBox(height: 10.h,),
             Container(
              height: 100.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Center(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText2(text: "✨ Effective Results", size: 20.sp, thisfontWeight: FontWeight.w500,
                       textColor: Color(0xff2C2C2C)),
                       SizedBox(height: 4.h,),
                      MyText2(text: "Our formulas are scientifically proven to deliver visible results.", size: 15.sp, thisfontWeight: FontWeight.w400,
                       textColor: Color(0xff8B8B8B),textAlign: TextAlign.start,),
                    ],
                  ),
                ),
              ),
             ),
             SizedBox(height: 24.h,),
              MyText(text: "Get in Touch", size: 24.sp, thisfontWeight: FontWeight.w600,
             textColor: Color(0xff2C2C2C)),
             SizedBox(height: 10.h,),
             InkWell(
                 onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactusScreen()));
                    },
                    
              child: Mybutton(text: "Contact Us",h: 37,s: 20,)),
             SizedBox(height: 30.h,),

            
              ],
            ),
          ),
        ),
      ),
    );
  }
}