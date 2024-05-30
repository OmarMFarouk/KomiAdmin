import 'dart:convert';

import 'package:http/http.dart' as http;

class AnalyticsApi {
  final baseUrl = "https://komiwall.com/app/admin/analytics";

  Future fetchAnalytics() async {
    http.Response response = await http.post(
      Uri.parse('$baseUrl/analytics.php'),
    );
    if (response.statusCode < 300) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      return 'error';
    }
  }

  Future fetchCountries() async {
    http.Response response = await http.post(
      Uri.parse('$baseUrl/users_countries.php'),
    );
    if (response.statusCode < 300) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      return 'error';
    }
  }
}
