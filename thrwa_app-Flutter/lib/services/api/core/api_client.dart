import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'api_response.dart';
import 'api_endpoints.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  ApiClient._internal();

  final http.Client client = http.Client();
  String? _token;

  Future<void> setToken(String token) async {
    _token = token;
    // await _storage.saveToken(token);
  }

  Future<void> clearToken() async {
    _token = null;
    // await _storage.clear();
  }

  // =======================
  // 🔹 HEADERS
  // =======================
  Map<String, String> _headers({Map<String, String>? extra}) {
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    if (_token != null) {
      headers["Authorization"] = "Bearer $_token";
    }

    if (extra != null) {
      headers.addAll(extra);
    }

    return headers;
  }

  // =======================
  // 🔹 GET
  // =======================
  Future<ApiResponse> get<T>({
    required path,
    Map<String, dynamic>? query,
  }) async {
    try {
      final uri = Uri.parse(
        ApiEndpoints.baseUrl + path,
      ).replace(queryParameters: query);

      final response = await client
          .get(uri, headers: _headers())
          .timeout(const Duration(seconds: 30)); //_headers(headers),
      return _handleResponse<T>(response);
    } on SocketException {
      return ApiFailure(message: "No internet connection", statusCode: null);
    } on TimeoutException {
      return ApiFailure(message: "Request timeout", statusCode: null);
    } catch (e) {
      return ApiFailure(message: "Unexpected error: $e", statusCode: null);
    }
  }

  // =======================
  // 🔹 POST (JSON)
  // =======================
  Future<ApiResponse> post({
    required String path,
    required Map<String, dynamic>? body,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse(ApiEndpoints.baseUrl + path),
            headers: _headers(), //_headers(headers),
            body: jsonEncode(body ?? {}),
          )
          .timeout(const Duration(seconds: 30));
      return _handleResponse(response);
    } on SocketException {
      return ApiFailure(message: "No internet connection", statusCode: null);
    } on TimeoutException {
      return ApiFailure(message: "Request timeout", statusCode: null);
    } catch (e) {
      return ApiFailure(message: "Unexpected error: $e", statusCode: null);
    }
  }

  // =======================
  // 🔥 MULTIPART (صور/ملفات)
  // =======================
  Future<ApiResponse> upload({
    required path,
    Map<String, String>? fields,
    List<File>? files,
    String fileField = "files",
  }) async {
    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse(ApiEndpoints.baseUrl + path),
      );

      request.headers.addAll(_headers());

      // 🔹 إضافة الحقول
      if (fields != null) {
        request.fields.addAll(fields);
      }

      // 🔹 إضافة الملفات
      if (files != null) {
        for (var file in files) {
          request.files.add(
            await http.MultipartFile.fromPath(fileField, file.path),
          );
        }
      }

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      return _handleResponse(response);
    } on SocketException {
      return ApiFailure(message: "No internet connection", statusCode: null);
    } on TimeoutException {
      return ApiFailure(message: "Request timeout", statusCode: null);
    } catch (e) {
      return ApiFailure(message: "Unexpected error: $e", statusCode: null);
    }
  }

  // =======================
  // 📌 PUT
  // =======================
  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? body,
    // Map<String, String>? headers,
  }) async {
    try {
      final response = await client
          .put(
            Uri.parse(ApiEndpoints.baseUrl + path),
            headers: _headers(), //_headers(headers),
            body: jsonEncode(body ?? {}),
          )
          .timeout(const Duration(seconds: 30));

      return _handleResponse(response);
    } on SocketException {
      return ApiFailure(message: "No internet connection", statusCode: null);
    } on TimeoutException {
      return ApiFailure(message: "Request timeout", statusCode: null);
    } catch (e) {
      return ApiFailure(message: "Unexpected error: $e", statusCode: null);
    }
  }

  // =======================
  // 📌 DELETE
  // =======================
  Future<ApiResponse> delete(
    String path /*  {Map<String, String>? headers,} */,
  ) async {
    try {
      final response = await client
          .delete(
            Uri.parse(ApiEndpoints.baseUrl + path),
            headers: _headers(), //_headers(headers),
          )
          .timeout(const Duration(seconds: 30));

      return _handleResponse(response);
    } on SocketException {
      return ApiFailure(message: "No internet connection", statusCode: null);
    } on TimeoutException {
      return ApiFailure(message: "Request timeout", statusCode: null);
    } catch (e) {
      return ApiFailure(message: "Unexpected error: $e", statusCode: null);
    }
  } // 🔥 RESPONSE HANDLER (محسن)

  // =======================
  Future<ApiResponse<Map<String, dynamic>>> _handleResponse<T>(
    http.Response response,
  ) async {
    final status = response.statusCode;
    dynamic data;

    try {
      data = response.body.isNotEmpty ? jsonDecode(response.body) : null;
    } catch (_) {
      data = response.body;
    }
    // ✅ Success
    if (status >= 200 && status < 300) {
      data = response.body.isNotEmpty ? jsonDecode(response.body) : null;
      Map<String, dynamic> dataJson =
          jsonDecode(response.body)['data']; //it depend on api.
      return ApiSuccess<Map<String, dynamic>>(data: dataJson);
    }

    // ❌ Extract message safely
    String message = "Something went wrong";

    if (data is Map) {
      message = data['message'] ?? data['error'] ?? data.toString();
    } else if (data is String) {
      message = data;
    }

    return ApiFailure(message: message, statusCode: status);
  }
}
