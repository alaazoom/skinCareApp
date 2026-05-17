// import 'package:ecommere2/logic/auth/forgetPass.dart';
// import 'package:ecommere2/ui/screens/auth/Verificationscreen.dart';
// import 'package:ecommere2/ui/widgets/myButton.dart';
// import 'package:ecommere2/ui/widgets/myText.dart';
// import 'package:ecommere2/ui/widgets/normalText.dart';
// import 'package:ecommere2/ui/widgets/textForm.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ForgotPasswordScreen extends StatelessWidget {
//    ForgotPasswordScreen({super.key});
//     TextEditingController emailController =
//       TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       backgroundColor: Color(0xffFAF8F5),
//       appBar: AppBar(
//         backgroundColor: Color(0xffFAF8F5),
//         title: MyText2(text: "Back to Login", size: 16.sp,
//          thisfontWeight: FontWeight.w400, textColor: Color(0xff5C6B4A)),

//       ),
//       body: Padding(
//         padding:  EdgeInsets.symmetric(horizontal: 24.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 33.h,),
//             MyText(text: "Forgot Password?", size: 36.sp,
//              thisfontWeight: FontWeight.w500, textColor: Color(0xff2C2C2C)),
//             SizedBox(height: 8.h,),
//             MyText(text: "Enter your email to receive a reset link", size: 16.sp,
//              thisfontWeight: FontWeight.w400, textColor: Color(0xff8B8B8B)),
//         SizedBox(height: 48.h,),
//              MyText2(text: "Email Address", size: 14.sp,
//                 thisfontWeight: FontWeight.w500, textColor: Color(0xff2C2C2C)),
//                  SizedBox(height: 8.h,),
//                  MyTextForm(hint: "your.email@example.com",suffix: false,c: emailController,),
//                  SizedBox(height: 56.h,),
//                  InkWell(
//                    onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>VerificationScreen()));
//                     },
//                   child: InkWell(
//                     onTap: (){ForgetPassService.forgotPassword(
//       context: context,
//       email: emailController.text,
//     );},
//                     child: Mybutton(text: "Send Reset Link",h: 37,s: 19,)))
                 
                 
        
        
        
//           ],
//         ),
//       ),
//     );
//   }
// }





// import 'package:ecommere2/logic/auth/forgetPass.dart';
// import 'package:ecommere2/ui/screens/auth/Verificationscreen.dart';
// import 'package:ecommere2/ui/widgets/myButton.dart';
// import 'package:ecommere2/ui/widgets/myText.dart';
// import 'package:ecommere2/ui/widgets/normalText.dart';
// import 'package:ecommere2/ui/widgets/textForm.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ForgotPasswordScreen extends StatefulWidget {
//   const ForgotPasswordScreen({super.key});

//   @override
//   State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
// }

// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   TextEditingController emailController = TextEditingController();

//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffFAF8F5),

//       appBar: AppBar(
//         backgroundColor: const Color(0xffFAF8F5),
//         title: Text(
//           "Back to Login",
//           style: TextStyle(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.w400,
//             color: const Color(0xff5C6B4A),
//           ),
//         ),
//       ),

//       body: Stack(
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 24.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 33.h),

//                 MyText(
//                   text: "Forgot Password?",
//                   size: 36.sp,
//                   thisfontWeight: FontWeight.w500,
//                   textColor: const Color(0xff2C2C2C),
//                 ),

//                 SizedBox(height: 8.h),

//                 MyText(
//                   text: "Enter your email to receive a reset link",
//                   size: 16.sp,
//                   thisfontWeight: FontWeight.w400,
//                   textColor: const Color(0xff8B8B8B),
//                 ),

//                 SizedBox(height: 48.h),

//                 MyText2(
//                   text: "Email Address",
//                   size: 14.sp,
//                   thisfontWeight: FontWeight.w500,
//                   textColor: const Color(0xff2C2C2C),
//                 ),

//                 SizedBox(height: 8.h),

//                 MyTextForm(
//                   hint: "your.email@example.com",
//                   suffix: false,
//                   c: emailController,
//                 ),

//                 SizedBox(height: 56.h),

//                 InkWell(
//                 onTap: () async {
//   setState(() => isLoading = true);

//   final success = await ForgetPassService.forgotPassword(
//     context: context,
//     email: emailController.text,
//   );

//   setState(() => isLoading = false);

//   if (success) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) =>
//             VerificationScreen(email: emailController.text),
//       ),
//     );
//   }
// },
//                   child: Mybutton(
//                     text: "Send Reset Link",
//                     h: 37,
//                     s: 19,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           if (isLoading)
//             Container(
//               color: Colors.black.withOpacity(0.4),
//               child: const Center(
//                 child: CircularProgressIndicator(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
















import 'package:ecommere2/logic/auth/forgetPass.dart';
import 'package:ecommere2/ui/screens/auth/Verificationscreen.dart';
import 'package:ecommere2/ui/widgets/myButton.dart';
import 'package:ecommere2/ui/widgets/myText.dart';
import 'package:ecommere2/ui/widgets/normalText.dart';
import 'package:ecommere2/ui/widgets/textForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController emailController =
      TextEditingController();

  bool isLoading = false;
  bool showMailAnimation = false;

  late AnimationController controller;
  late Animation<Offset> offsetAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -8),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF8F5),

      appBar: AppBar(
        backgroundColor: const Color(0xffFAF8F5),
        title: Text(
          "Back to Login",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xff5C6B4A),
          ),
        ),
      ),

      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 33.h),
              
                  MyText(
                    text: "Forgot Password?",
                    size: 36.sp,
                    thisfontWeight: FontWeight.w500,
                    textColor:
                        const Color(0xff2C2C2C),
                  ),
              
                  SizedBox(height: 8.h),
              
                  MyText(
                    text:
                        "Enter your email to receive a reset link",
                    size: 16.sp,
                    thisfontWeight: FontWeight.w400,
                    textColor:
                        const Color(0xff8B8B8B),
                  ),
              
                  SizedBox(height: 48.h),
              
                  MyText2(
                    text: "Email Address",
                    size: 14.sp,
                    thisfontWeight: FontWeight.w500,
                    textColor:
                        const Color(0xff2C2C2C),
                  ),
              
                  SizedBox(height: 8.h),
              
                  MyTextForm(
                    hint:
                        "your.email@example.com",
                    suffix: false,
                    c: emailController,
                  ),
              
                  SizedBox(height: 56.h),
              
                  InkWell(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
              
                      final success =
                          await ForgetPassService
                              .forgotPassword(
                        context: context,
                        email:
                            emailController.text,
                      );
              
                      setState(() {
                        isLoading = false;
                      });
              
                      if (success) {
                        setState(() {
                          showMailAnimation = true;
                        });
              
                        controller.forward();
              
                        await Future.delayed(
                          const Duration(
                            milliseconds: 2500,
                          ),
                        );
              
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                VerificationScreen(
                              email:
                                  emailController
                                      .text,
                            ),
                          ),
                        );
                      }
                    },
                    child: Mybutton(
                      text: "Send Reset Link",
                      h: 37,
                      s: 19,
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (isLoading)
            Container(
              color:
                  Colors.black.withOpacity(0.4),
              child: const Center(
                child:
                    CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),

          if (showMailAnimation)
            Center(
              child: SlideTransition(
                position: offsetAnimation,
                child: TweenAnimationBuilder(
                  tween: Tween<double>(
                    begin: 0.5,
                    end: 1.3,
                  ),
                  duration:
                      const Duration(
                    milliseconds: 2000,
                  ),
                  builder:
                      (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: child,
                    );
                  },
                  child: Icon(
                    Icons.mail_rounded,
                    size: 100.sp,
                    color:
                        const Color(0xff5C6B4A),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}