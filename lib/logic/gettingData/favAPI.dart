import 'dart:convert';
import 'package:http/http.dart' as http;

class FavApi {
  final String baseUrl;
  FavApi(this.baseUrl);

  Map<String, String> _headers(String token) => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };


      Future<Map<String, dynamic>> getFavorites(String token) async {
  final response = await http.get(
    Uri.parse('$baseUrl/customer/favorites'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  return jsonDecode(response.body);
}

  Future<Map<String, dynamic>> addFav(String token, int productId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/customer/favorites/add'),
      headers: _headers(token),
      body: jsonEncode({"product_id": productId}),
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> removeFav(String token, int productId) async {
    // ملاحظة: إذا لم ينجح الـ DELETE مع الـ Body، جرب تحويلها لـ POST
    final response = await http.delete( 
      Uri.parse('$baseUrl/customer/favorites/remove'),
      headers: _headers(token),
      body: jsonEncode({"product_id": [productId]}),
    );
    return jsonDecode(response.body);
  }
}