import 'dart:convert';
import 'package:ecommere2/logic/cache/privacyCache.dart';
import 'package:http/http.dart' as http;

class PrivacyRepository {
  final PrivacyCache cache;

  PrivacyRepository(this.cache);

  Future<String> fetchPrivacy() async {
    final url = Uri.parse("https://tullana.toldpath.com/api/customer/profile/help-center/privacy-policy");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final data = json['data'];

      await cache.save(data);
      return data;
    } else {
      throw Exception("Failed to load privacy policy");
    }
  }

  Future<String?> getCached() async {
    return await cache.get();
  }
}