import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminApi {
  final baseUrl = "https://komiwall.com/app/admin";

  Future fetchAdminData() async {
    http.Response response =
        await http.post(Uri.parse('$baseUrl/admin_fbi.php'));
    if (response.statusCode < 300) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      return 'error';
    }
  }

  Future fetchConfigs() async {
    http.Response response =
        await http.post(Uri.parse('$baseUrl/security/security_options.php'));
    if (response.statusCode < 300) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      return 'error';
    }
  }

  Future announceUser(token, title, body) async {
    http.Response response = await http.post(
        Uri.parse('$baseUrl/p2p_announcement.php'),
        body: {"token": token, "title": title, "body": body});
    if (response.statusCode < 300) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      return 'error';
    }
  }

  Future announceUsers(title, body) async {
    http.Response response = await http.post(
        Uri.parse('$baseUrl/announcement.php'),
        body: {"title": title, "body": body});
    if (response.statusCode < 300) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      return 'error';
    }
  }

  saveAdminData(name, password, percentage, path) async {
    Map<String, String> data = {
      "name": name,
      "password": password,
      'percentage': percentage,
      "path": path
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/admin_edit.php"),
    );
    request.fields.addAll(data);
    if (path != '') {
      var multipartFile = await http.MultipartFile.fromPath(
          'file', path); //returns a Future<MultipartFile>
      request.files.add(multipartFile);
    }

    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();

    var jsonData = await jsonDecode(respStr);
    if (response.statusCode < 300) {
      return await jsonData;
    } else {
      return 'error';
    }
  }

  Future editConfigs(id, fakeEmail, vpn, multipleAccounts) async {
    http.Response response = await http
        .post(Uri.parse('$baseUrl/security/edit_security_options.php'), body: {
      'id': id,
      'fakeEmail': fakeEmail,
      'vpn': vpn,
      'multipleAccounts': multipleAccounts
    });
    if (response.statusCode < 300) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      return 'error';
    }
  }
}
