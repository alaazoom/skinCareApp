import 'dart:convert';

import 'package:ecommere2/ui/screens/auth/loginscreen.dart';
import 'package:ecommere2/ui/widgets/myButton.dart';
import 'package:ecommere2/ui/widgets/myText.dart';
import 'package:ecommere2/ui/widgets/normalText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String code;

  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.code,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  bool isLoading = false;

  Future<void> resetPassword() async {
  print("🚀 RESET PASSWORD STARTED");

  if (passwordController.text.isEmpty ||
      confirmController.text.isEmpty) {
    print("⚠️ VALIDATION FAILED: empty fields");

    _showTopSnackBar(
      context,
      message: "Please fill all fields",
      color: Colors.orange,
    );
    return;
  }

  if (passwordController.text != confirmController.text) {
    print("⚠️ VALIDATION FAILED: passwords not match");

    _showTopSnackBar(
      context,
      message: "Passwords do not match",
      color: Colors.red,
    );
    return;
  }

  setState(() {
    isLoading = true;
  });

  try {
    final url = Uri.parse(
      "https://tullana.toldpath.com/api/customer/auth/reset-password",
    );

    print("📡 REQUEST URL: $url");

    final body = {
      "email": widget.email,
      "token": widget.code,
      "password": passwordController.text,
      "confirm_password": confirmController.text,
    };

    print("📦 REQUEST BODY: $body");

    final response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    print("📡 STATUS CODE: ${response.statusCode}");
    print("📡 RAW RESPONSE: ${response.body}");

    final data = jsonDecode(response.body);

    print("📦 DECODED RESPONSE: $data");

    if (response.statusCode == 200) {
      print("✅ STATUS CODE OK (200)");

      _showTopSnackBar(
        context,
        message: data["message"] ?? "Password reset successful",
        color: Colors.green,
      );

      print("➡️ NAVIGATING TO LOGIN");

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      });
    } else {
      print("❌ SERVER ERROR STATUS CODE != 200");

      _showTopSnackBar(
        context,
        message: data["message"] ?? "Reset failed",
        color: Colors.red,
      );
    }
  } catch (e, stack) {
    print("🔥 EXCEPTION OCCURRED");
    print("ERROR: $e");
    print("STACKTRACE: $stack");

    _showTopSnackBar(
      context,
      message: "Error: $e",
      color: Colors.red,
    );
  }

  print("🏁 RESET PASSWORD FINISHED");

  setState(() {
    isLoading = false;
  });
}

  // Future<void> resetPassword() async {
  //   if (passwordController.text.isEmpty ||
  //       confirmController.text.isEmpty) {
  //     _showTopSnackBar(
  //       context,
  //       message: "Please fill all fields",
  //       color: Colors.orange,
  //     );
  //     return;
  //   }

  //   if (passwordController.text != confirmController.text) {
  //     _showTopSnackBar(
  //       context,
  //       message: "Passwords do not match",
  //       color: Colors.red,
  //     );
  //     return;
  //   }

  //   setState(() {
  //     isLoading = true;
  //   });

  //   try {
  //     final url = Uri.parse(
  //       "https://tullana.toldpath.com/api/customer/auth/reset-password",
  //     );

  //     final response = await http.post(
  //       url,
  //       headers: {
  //         "Content-Type": "application/json",
  //       },
  //       body: jsonEncode({
  //         "email": widget.email,
  //         "token": widget.code,
  //         "password": passwordController.text,
  //         "confirm_password": confirmController.text,
  //       }),
  //     );

  //     final data = jsonDecode(response.body);

  //     if (response.statusCode == 200) {
  //       _showTopSnackBar(
  //         context,
  //         message: data["message"] ?? "Password reset successful",
  //         color: Colors.green,
  //       );

  //       Future.delayed(const Duration(seconds: 1), () {
  //         Navigator.push(
  //           context,
  //          MaterialPageRoute(builder: (context)=>LoginScreen()),
  //         );
  //       });
  //     } else {
  //       _showTopSnackBar(
  //         context,
  //         message: data["message"] ?? "Reset failed",
  //         color: Colors.red,
  //       );
  //     }
  //   } catch (e) {
  //     _showTopSnackBar(
  //       context,
  //       message: "Error: $e",
  //       color: Colors.red,
  //     );
  //   }

  //   setState(() {
  //     isLoading = false;
  //   });
  // }

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
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF8F5),

      appBar: AppBar(
        backgroundColor: const Color(0xffFAF8F5),
        elevation: 0,
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 33.h),
          
              MyText(
                text: "Reset Password",
                size: 36.sp,
                thisfontWeight: FontWeight.w500,
                textColor: const Color(0xff2C2C2C),
              ),
          
              SizedBox(height: 7.h),
          
              MyText2(
                text: "Enter your new password",
                size: 16.sp,
                thisfontWeight: FontWeight.w400,
                textColor: const Color(0xff8B8B8B),
              ),
          
              SizedBox(height: 49.h),
          
              /// PASSWORD
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "New Password",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
          
              SizedBox(height: 16.h),
          
              /// CONFIRM PASSWORD
              TextField(
                controller: confirmController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
          
              SizedBox(height: 33.h),
          
              InkWell(
                onTap: isLoading ? null : resetPassword,
          
                child: Mybutton(
                  text: isLoading ? "Loading..." : "Reset Password",
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