import 'dart:convert';
import 'package:ecommere2/ui/screens/auth/Verificationscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class ForgetPassService {
  static const String baseUrl = "https://tullana.toldpath.com/api";

static Future<bool> forgotPassword({
  required BuildContext context,
  required String email,
}) async {
  final url = Uri.parse(
    "$baseUrl/customer/auth/forgot-password?email=$email",
  );

  try {
    final response = await http.post(url);
    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data["status"] == "otp_sent") {
      _showTopSnackBar(
        context,
        message: data["message"] ?? "Success",
        color: Colors.green,
      );

      return true;
    } else {
      _showTopSnackBar(
        context,
        message: data["message"] ?? "Something went wrong",
        color: Colors.red,
      );

      return false; 
    }
  } catch (e) {
    _showTopSnackBar(
      context,
      message: "Error: $e",
      color: Colors.red,
    );

    return false;
  }
}
  }

   void _showTopSnackBar(
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

        margin:  EdgeInsets.only(
          top: 20,
          left: 16,
          right: 16,
          bottom: 20.h
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
