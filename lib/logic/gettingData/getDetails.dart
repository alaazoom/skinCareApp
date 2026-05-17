import 'dart:convert';
import 'package:ecommere2/logic/models/onrProductModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailsRepository {
  static const cacheKey = "product_details_cache_";

  Future<ProductDetailsModel> getProductDetails(String slug) async {
    final prefs = await SharedPreferences.getInstance();

    final url = Uri.parse(
      "https://tullana.toldpath.com/api/customer/products/details/${slug}",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        await prefs.setString(
          cacheKey + slug,
          jsonEncode(data),
        );

        return ProductDetailsModel.fromJson(data);
      } else {
        throw Exception("Server error");
      }
    } catch (e) {
      final cached = prefs.getString(cacheKey + slug);

      if (cached != null) {
        return ProductDetailsModel.fromJson(jsonDecode(cached));
      }

      throw Exception("No Internet & No Cache");
    }
  }
}