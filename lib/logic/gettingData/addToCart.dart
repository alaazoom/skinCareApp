import 'dart:convert';
import 'package:ecommere2/logic/models/cartitemModel.dart';
import 'package:http/http.dart' as http;

class CartApi {
  final String baseUrl;

  CartApi(this.baseUrl);
  Future<CartResponse> getCart(String token) async {
    final res = await http.get(
      Uri.parse("$baseUrl/customer/cart"),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    final data = jsonDecode(res.body);

    print("CART RESPONSE: $data");

    if (res.statusCode == 200 && data["status"] == true) {
      return CartResponse.fromJson(data);
    }

    throw Exception("Failed to load cart");
  }

  Future<Map<String, dynamic>> addToCart({
    required String token,
    required int productId,
    required int quantity,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/customer/cart/add?id=$productId"),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "product_id": productId,
        "quantity": quantity,
      }),
    );

    return jsonDecode(response.body);
  }



  Future<Map<String, dynamic>> removeFromCart({
  required String token,
  required int cartId,
}) async {
  final response = await http.delete(
    Uri.parse("$baseUrl/customer/cart/remove"),
    headers: {
      "Authorization": "Bearer $token",
      "Accept": "application/json",
      "Content-Type": "application/json",
    },
    body: jsonEncode({
      "key": cartId,
    }),
  );

  final data = jsonDecode(response.body);

  if (response.statusCode == 200 && data["status"] == true) {
    return data;
  }

  throw Exception(
    data["message"] ?? "Failed to remove product",
  );
}
}