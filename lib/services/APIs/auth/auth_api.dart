import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../models/auth_model.dart';

class AuthApi {
  final baseUrl = "https://komiwall.com/app/admin/auth";

  Future loginAdmin(AuthModel authModel) async {
    http.Response response = await http.post(Uri.parse('$baseUrl/login.php'),
        body: authModel.toJson());
    if (response.statusCode < 300) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      return 'error';
    }
  }
}
