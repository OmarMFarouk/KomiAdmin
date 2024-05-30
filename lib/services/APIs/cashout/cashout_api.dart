import 'dart:convert';
import 'package:http/http.dart' as http;

class CashoutApi {
  final baseUrl = "https://komiwall.com/app/admin/cashout";

  Future fetchTransactions() async {
    http.Response response = await http.post(
      Uri.parse('$baseUrl/transactions.php'),
    );
    if (response.statusCode < 300) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      return 'error';
    }
  }

  Future fetchMethods() async {
    http.Response response = await http.post(
      Uri.parse('$baseUrl/methods.php'),
    );
    if (response.statusCode < 300) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      return 'error';
    }
  }

  Future markCompleted(username, id) async {
    http.Response response = await http.post(
        Uri.parse('$baseUrl/complete_transaction.php'),
        body: {'username': username, 'transaction_id': id});
    if (response.statusCode < 300) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      return 'error';
    }
  }

  Future markRejected(username, id) async {
    http.Response response = await http.post(
        Uri.parse('$baseUrl/reject_transaction.php'),
        body: {'username': username, 'transaction_id': id});
    if (response.statusCode < 300) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      return 'error';
    }
  }

  Future deactivateMethod(id) async {
    http.Response response = await http
        .post(Uri.parse('$baseUrl/deactivate_method.php'), body: {'id': id});
    if (response.statusCode < 300) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      return 'error';
    }
  }

  Future activateMethod(id) async {
    http.Response response = await http
        .post(Uri.parse('$baseUrl/activate_method.php'), body: {'id': id});
    if (response.statusCode < 300) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      return 'error';
    }
  }

  Future deleteMethod(id) async {
    http.Response response = await http
        .post(Uri.parse('$baseUrl/delete_method.php'), body: {'id': id});
    if (response.statusCode < 300) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      return 'error';
    }
  }

  addMethod(method, tierValue, tierPoints, path) async {
    Map<String, String> data = {
      "method": method,
      "tier_value": tierValue,
      'tier_points': tierPoints
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/add_method.php"),
    );
    request.fields.addAll(data);

    var multipartFile = await http.MultipartFile.fromPath(
        'file', path); //returns a Future<MultipartFile>
    request.files.add(multipartFile);
    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    var jsonData = await jsonDecode(respStr);
    if (response.statusCode < 300) {
      return await jsonData;
    } else {
      return 'error';
    }
  }

  Future editMethod(id, method, tierPoints, tierValue, path) async {
    Map<String, String> data = {
      'id': id,
      'title': method,
      'tier_points': tierPoints,
      'tier_value': tierValue,
      'path': path,
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/edit_method.php"),
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
}
