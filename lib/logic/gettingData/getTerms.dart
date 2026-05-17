import 'dart:convert';
import 'package:ecommere2/logic/cache/termsCache.dart';
import 'package:http/http.dart' as http;

class TermsRepository {
  final TermsCache cache;

  TermsRepository(this.cache);

  Future<String> fetchTerms() async {
    final url = Uri.parse("https://tullana.toldpath.com/api/customer/profile/help-center/terms-conditions");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      final data = json['data'];
      await cache.save(data);
      return data;
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<String?> getCached() async {
    return await cache.get();
  }
}