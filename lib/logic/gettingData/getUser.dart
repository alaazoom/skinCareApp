import 'dart:convert';
import 'package:ecommere2/logic/models/userModel.dart';
import 'package:http/http.dart' as http;

class UserApi {
  final String baseUrl;

  UserApi(this.baseUrl);

 Future<UserModel> getUser(String token) async {
  final response = await http.get(
    Uri.parse("$baseUrl/customer/profile/info"),
    headers: {
      "Authorization": "Bearer $token",
      "Accept": "application/json",
    },
  );

  print("STATUS CODE: ${response.statusCode}");
  print("BODY: ${response.body}");

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return UserModel.fromJson(data['user']);
  } else {
    throw Exception("Failed: ${response.statusCode}");
  }
}
}