// import 'package:ecommere2/ui/screens/auth/loginscreen.dart';
// import 'package:ecommere2/ui/screens/auth/onBoarding.dart';
// import 'package:ecommere2/ui/widgets/myText.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     Future.delayed(const Duration(seconds:3), () {
//   Navigator.pushAndRemoveUntil(
//     context,
//     MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
//     (route) => false, 
//   );
// }); 
// //OnBoardingScreen
// //LoginScreen

//     // TODO: implement initState
//     super.initState();
//   }
//   @override
  
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       backgroundColor: Color(0xffFAF8F5),
//       body: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [ 
//             SizedBox(height:119.h),
//             Image.asset("images/logo.png",height:128.h ,width:128.w,fit:BoxFit.contain),
//             SizedBox(height:24.h),
//             MyText(text: "Natural Beauty", size: 48.sp,
//              thisfontWeight: FontWeight.w500, textColor: Color(0xff2C2C2C)),
//             SizedBox(height:12.h),
//             // MyText(text: "Skin Care Essentials", size: 18.sp,
//             //  thisfontWeight: FontWeight.w400, textColor: Color(0xff8B8B8B)),
//              Text("Skin Care Essentials",style: TextStyle(fontSize: 18.sp,
//              fontWeight: FontWeight.w400, color: Color(0xff8B8B8B)),),
//              SizedBox(height:62.h),
//              LoadingAnimationWidget.threeArchedCircle(
//                       color: Color(0xff5C6B4A),
//                       size: 40,
//                     ),
//              SizedBox(height:67.h),
//              //
//              Text("Pure • Natural • Sustainable",style: TextStyle(fontSize: 14.sp,
//              fontWeight: FontWeight.w400, color: Color(0xff8B8B8B)),),
        
        
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:ecommere2/ui/screens/auth/loginscreen.dart';
import 'package:ecommere2/ui/screens/auth/onBoarding.dart';
import 'package:ecommere2/ui/widgets/myText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// 👈 تم إضافة TickerProviderStateMixin لتشغيل الأنيميشن
class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _rotationController;

  @override
  void initState() {
    super.initState();

    // 👈 إعداد وحدة التحكم بالأنيميشن (الدوران يأخذ ثانية ونصف لكل لفة كاملة ويعيد نفسه)
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(); // repeat تجعل الدوران مستمراً طوال الـ 3 ثواني

    // النطاق الزمني للانتقال إلى الشاشة التالية
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
        (route) => false,
      );
    });
  }

  @override
  void dispose() {
    // 👈 إغلاق الـ controller لحماية الذاكرة من التسريب
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF8F5),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 119.h),
            
            // 👈 تم تغليف اللوجو بـ RotationTransition ليدور، وجعلناه دائرياً بـ ClipRRect
            RotationTransition(
              turns: _rotationController,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.r), // لجعل الصورة دائرية تماماً
                child: Image.asset(
                  "images/logo.png",
                  height: 128.h,
                  width: 128.w,
                  fit: BoxFit.contain, // تم تغييرها لـ cover لضمان ملء الدائرة بشكل صحيح
                ),
              ),
            ),
            
            SizedBox(height: 24.h),
            MyText(
              text: "Natural Beauty",
              size: 48.sp,
              thisfontWeight: FontWeight.w500,
              textColor: const Color(0xff2C2C2C),
            ),
            SizedBox(height: 12.h),
            Text(
              "Skin Care Essentials",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xff8B8B8B),
              ),
            ),
            SizedBox(height: 62.h),
            // LoadingAnimationWidget.threeArchedCircle(
            //   color: const Color(0xff5C6B4A),
            //   size: 40,
            // ),
            SizedBox(height: 67.h),
            Text(
              "Pure • Natural • Sustainable",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xff8B8B8B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}