import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IssueService {

  Future<Map<String, dynamic>?> sendIssue({
    required String issueType,
    required String description,
  }) async {

    final connectivity = await Connectivity().checkConnectivity();

    if (connectivity == ConnectivityResult.none) {
      return {"status": false, "message": "No Internet Connection"};
    }

    final url = Uri.parse("https://tullana.toldpath.com/api/customer/technical-support/create");

    try {
      final prefs = await SharedPreferences.getInstance();

final token = prefs.getString("token");
      final response = await http.post(
        url,
        
        headers: {
          "Authorization": "Bearer $token",
          'Content-Type': 'application/json',
          "Accept": "application/json",
        },
        body: jsonEncode({
          "issue_type": issueType,
          "description": description,
        }),
      );

      return jsonDecode(response.body);

    } catch (e) {
      return {"status": false, "message": "Something went wrong"};
    }
  }
}