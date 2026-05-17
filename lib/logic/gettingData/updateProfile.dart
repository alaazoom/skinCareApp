import 'dart:convert';
import 'package:http/http.dart' as http;

class UpdateProfileApi {
  Future<Map<String, dynamic>> updateProfile({
    required String token,
    required String firstName,
    required String lastName,
    required String email,
    required String countryCode,
    required String mobile,
  }) async {

    final response = await http.post(
      Uri.parse(
        "https://tullana.toldpath.com/api/customer/profile/update-profile",
      ),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
      body: {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "country_code": countryCode,
        "mobile": mobile,
      },
    );

    print("Status: ${response.statusCode}");
    print("Body: ${response.body}");

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {

      String errorMessage = "Update Failed";

      if (data["message"] != null) {
        errorMessage = data["message"];
      }

      if (data["errors"] != null) {
        errorMessage = data["errors"].toString();
      }

      throw Exception(errorMessage);
    }
  }
}