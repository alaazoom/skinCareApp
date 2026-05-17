// import 'package:ecommere2/ui/widgets/myButton.dart';
// import 'package:ecommere2/ui/widgets/myText.dart';
// import 'package:ecommere2/ui/widgets/normalText.dart';
// import 'package:ecommere2/ui/widgets/ver.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class VerificationScreen extends StatelessWidget {
//   const VerificationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        appBar: AppBar(
//         backgroundColor: Color(0xffFAF8F5),
   

//       ),
//       backgroundColor: Color(0xffFAF8F5),
//       body: Padding(
//         padding:  EdgeInsets.symmetric(horizontal: 24.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//           SizedBox(height: 33.h ,),
//           MyText(text: "Verification", size: 36.sp,
//            thisfontWeight: FontWeight.w500, textColor: Color(0xff2C2C2C)),
//           SizedBox(height: 7.h ,),
//           MyText2(text: "Enter the 6-digit code sent to your email", size: 16.sp,
//            thisfontWeight: FontWeight.w400, textColor: Color(0xff8B8B8B)),
//            SizedBox(height: 49.h,),
//            OtpCodeFields(),
//            SizedBox(height: 32.h ,),
//           Center(
//             child: MyText2(text: "Didn't receive the code?", size: 16.sp,
//              thisfontWeight: FontWeight.w400, textColor: Color(0xff8B8B8B)),
//           ),
//            SizedBox(height: 9.h ,),
//           Center(
//             child: MyText2(text: "Resend Code", size: 16.sp,
//              thisfontWeight: FontWeight.w500, textColor: Color(0xff5C6B4A)),
//           ),
//           SizedBox(height: 33.h ,),
//           Mybutton(text: "Verify",h: 34,s: 19,)
        
//         ],),
//       ),


//     );
//   }
// }













import 'dart:convert';

import 'package:ecommere2/ui/screens/auth/resetPassword.dart';
import 'package:ecommere2/ui/widgets/myButton.dart';
import 'package:ecommere2/ui/widgets/myText.dart';
import 'package:ecommere2/ui/widgets/normalText.dart';
import 'package:ecommere2/ui/widgets/ver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class VerificationScreen extends StatefulWidget {
  final String email;

  const VerificationScreen({
    super.key,
    required this.email,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController codeController = TextEditingController();

  bool isLoading = false;

  Future<void> verifyOtp() async {
    if (codeController.text.isEmpty || codeController.text.length != 4) {
      _showTopSnackBar(
        context,
        message: "Enter valid 4-digit code",
        color: Colors.orange,
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final url = Uri.parse(
        "https://tullana.toldpath.com/api/customer/auth/verify-otp",
      );

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": widget.email,
          "token": codeController.text,
        }),
      );

      final data = jsonDecode(response.body);
if (response.statusCode == 200 &&
    data["status"] == "otp_verified") {

  _showTopSnackBar(
    context,
    message: data["message"],
    color: Colors.green,
  );

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ResetPasswordScreen(
        email: widget.email,
        code: codeController.text,
      ),
    ),
  );
}else {
        _showTopSnackBar(
          context,
          message: data["message"] ?? "Verification failed",
          color: Colors.red,
        );
      }
    } catch (e) {
      _showTopSnackBar(
        context,
        message: "Error: $e",
        color: Colors.red,
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  static void _showTopSnackBar(
    BuildContext context, {
    required String message,
    required Color color,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        elevation: 12,
        duration: const Duration(seconds: 3),
        margin: EdgeInsets.only(
          top: 20,
          left: 16,
          right: 16,
          bottom: 20.h,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFAF8F5),
      ),
      backgroundColor: const Color(0xffFAF8F5),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 33.h),
          
              MyText(
                text: "Verification",
                size: 36.sp,
                thisfontWeight: FontWeight.w500,
                textColor: const Color(0xff2C2C2C),
              ),
          
              SizedBox(height: 7.h),
          
              MyText2(
                text: "Enter the 6-digit code sent to your email",
                size: 16.sp,
                thisfontWeight: FontWeight.w400,
                textColor: const Color(0xff8B8B8B),
              ),
          
              SizedBox(height: 49.h),
          
              OtpCodeFields(
            controller: codeController,
          ),
          
              SizedBox(height: 32.h),
          
              Center(
                child: MyText2(
                  text: "Didn't receive the code?",
                  size: 16.sp,
                  thisfontWeight: FontWeight.w400,
                  textColor: const Color(0xff8B8B8B),
                ),
              ),
          
              SizedBox(height: 9.h),
          
              Center(
                child: MyText2(
                  text: "Resend Code",
                  size: 16.sp,
                  thisfontWeight: FontWeight.w500,
                  textColor: const Color(0xff5C6B4A),
                ),
              ),
          
              SizedBox(height: 33.h),
          
              InkWell(
                onTap: isLoading ? null : verifyOtp,
          
                child: Mybutton(
                  text: isLoading ? "Loading..." : "Verify",
                  h: 34,
                  s: 19,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}