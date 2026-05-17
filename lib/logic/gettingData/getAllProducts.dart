// // import 'dart:convert';
// // import 'package:ecommere2/logic/models/productModel.dart';
// // import 'package:http/http.dart' as http;

// // class ProductsRepository {
// //   Future<List<ProductModel>> getProducts() async {
// //     final url = Uri.parse("https://tullana.toldpath.com/api/customer/categories/products/247");

// //     final response = await http.get(url);

// //     if (response.statusCode == 200) {
// //       final data = jsonDecode(response.body);

// //       final result = ProductResponse.fromJson(data);

// //       return result.data;
// //     } else {
// //       throw Exception("Failed to load products");
// //     }
// //   }
// // }

// import 'dart:convert';
// import 'package:ecommere2/logic/checkInternet.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// import 'package:ecommere2/logic/models/productModel.dart';

// class ProductsRepository {
//   final InternetChecker internetChecker;

//   ProductsRepository(this.internetChecker);

//   static const String cacheKey = "products_cache";

//   Future<List<ProductModel>> getProducts() async {
//     final prefs = await SharedPreferences.getInstance();

//     bool hasInternet = await internetChecker.hasInternet();

//     // 🌐 ONLINE
//     if (hasInternet) {
//       final url = Uri.parse("https://tullana.toldpath.com/api/customer/categories/products/247");
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         final result = ProductResponse.fromJson(data);

//         // 💾 cache data
//         await prefs.setString(cacheKey, jsonEncode(data));

//         return result.data;
//       } else {
//         throw Exception("Server Error");
//       }
//     }

//     // 📴 OFFLINE
//     else {
//       final cachedData = prefs.getString(cacheKey);

//       if (cachedData != null) {
//         final data = jsonDecode(cachedData);
//         final result = ProductResponse.fromJson(data);

//         return result.data;
//       } else {
//         throw Exception("No Internet & No Cache");
//       }
//     }
//   }
// }


import 'dart:convert';
import 'package:ecommere2/logic/checkInternet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:ecommere2/logic/models/productModel.dart';

class ProductsRepository {
  final InternetChecker internetChecker;

  ProductsRepository(this.internetChecker);

  static const String cacheKey = "products_cache";

  Future<List<ProductModel>> getProducts() async {
    final prefs = await SharedPreferences.getInstance();

    final hasInternet = await internetChecker.hasInternet();

    if (hasInternet) {
      try {
        final url = Uri.parse(
          "https://tullana.toldpath.com/api/customer/categories/products/247",
        );

        final response = await http.get(url);

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);

          final result = ProductResponse.fromJson(data);

          await prefs.setString(cacheKey, jsonEncode(data));

          return result.data;
        } else {
          throw Exception("Server Error");
        }
      } catch (e) {
        throw Exception("Network Error");
      }
    } else {
      // 📴 Offline
      final cachedData = prefs.getString(cacheKey);

      if (cachedData != null) {
        final data = jsonDecode(cachedData);
        final result = ProductResponse.fromJson(data);

        return result.data;
      } else {
        throw Exception("No Internet & No Cache");
      }
    }
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(cacheKey);
  }
}