import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  static Future get(String endpoint) async {
    String baseUrl = "fakestoreapi.com";

    final response = await http.get(
      Uri.https(baseUrl, "/$endpoint"),
    );
    return _handleResponse(response);
  }

  static Future<http.Response> post(
      String endpoint, Map<String, dynamic> data) async {
    String baseUrl = "fakestoreapi.com";
    final response = await http.post(
      headers: {
        'Content-Type': 'application/json',
      },
      Uri.https(baseUrl, "/$endpoint"),
      body: jsonEncode(data),
    );

    return _handleResponse(response);
  }

  static Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    String baseUrl = "fakestoreapi.com";
    final response = await http.put(
      Uri.https(baseUrl, "/products/$endpoint"),
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  static Future<dynamic> delete(String endpoint) async {
    String baseUrl = "fakestoreapi.com";
    final response = await http.delete(
      Uri.https(baseUrl, "/$endpoint"),
    );
    return _handleResponse(response);
  }

  static http.Response _handleResponse(http.Response response) {
    return response;
  }
}
