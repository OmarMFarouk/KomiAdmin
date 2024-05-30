import 'dart:convert';
import 'package:http/http.dart' as http;

class OfferWallsApi {
  final baseUrl = "https://komiwall.com/app/admin/offerwalls";

  Future fetchOfferWalls() async {
    http.Response response = await http.post(
      Uri.parse('$baseUrl/offerwalls.php'),
    );
    if (response.statusCode < 300) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      return 'error';
    }
  }

  Future deactivateOfferwall(id) async {
    http.Response response = await http
        .post(Uri.parse('$baseUrl/deactivate_offerwall.php'), body: {'id': id});
    if (response.statusCode < 300) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      return 'error';
    }
  }

  Future activateOfferwall(id) async {
    http.Response response = await http
        .post(Uri.parse('$baseUrl/activate_offerwall.php'), body: {'id': id});
    if (response.statusCode < 300) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      return 'error';
    }
  }

  Future deleteNetwork(id) async {
    http.Response response = await http
        .post(Uri.parse('$baseUrl/delete_offerwall.php'), body: {'id': id});
    if (response.statusCode < 300) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      return 'error';
    }
  }

  addNetwork(name, url, rate, path, skin) async {
    Map<String, String> data = {
      "name": name,
      "url": url,
      "rate": rate,
      "skin": skin
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/add_offerwall.php"),
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

  Future editNetwork(id, title, url, rate, path) async {
    Map<String, String> data = {
      'id': id,
      'title': title,
      'url': url,
      'rate': rate,
      'path': path,
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/edit_network.php"),
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
      print(jsonData);
      print(id);
      return await jsonData;
    } else {
      return 'error';
    }
  }
}
