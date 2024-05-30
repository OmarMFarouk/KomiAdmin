import 'dart:convert';
import 'package:http/http.dart' as http;

class UserApi {
  final baseUrl = "https://komiwall.com/app/admin/users";

  Future fetchUsers() async {
    http.Response response = await http.post(
      Uri.parse('$baseUrl/users.php'),
    );
    if (response.statusCode < 300) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      return 'error';
    }
  }

  Future fetchUserInfo(username) async {
    http.Response response = await http
        .post(Uri.parse('$baseUrl/user_fbi.php'), body: {'username': username});
    if (response.statusCode < 300) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      return 'error';
    }
  }

  Future deleteUser(username, reason) async {
    http.Response response = await http.post(
        Uri.parse('$baseUrl/delete_user.php'),
        body: {'username': username, 'reason': reason});
    if (response.statusCode < 300) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      return 'error';
    }
  }

  Future banUser(username, reason) async {
    http.Response response = await http.post(Uri.parse('$baseUrl/ban_user.php'),
        body: {'username': username, 'reason': reason});
    if (response.statusCode < 300) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      return 'error';
    }
  }

  Future editBalance(username, points) async {
    http.Response response = await http.post(
        Uri.parse('$baseUrl/edit_user_balance.php'),
        body: {'username': username, 'points': points});
    if (response.statusCode < 300) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      return 'error';
    }
  }
}
