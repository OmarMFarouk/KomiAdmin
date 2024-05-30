import 'dart:convert';

import 'package:http/http.dart' as http;

class LeadsApi {
  final String baseUrl = "https://komiwall.com/app/admin/leads";

  Future fetchLeads() async {
    http.Response request = await http.get(Uri.parse("$baseUrl/leads.php"));

    if (request.statusCode < 300) {
      var response = jsonDecode(request.body);

      return response;
    } else {
      return 'error';
    }
  }
}
