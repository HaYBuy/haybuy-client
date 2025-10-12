import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:haybuy_client/utils/constants/api_constants.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() => 'ApiException: $message (Status Code: $statusCode)';
}

class ApiService {
  final Logger _logger = Logger();
  final String baseUrl;

  ApiService({String? baseUrl}) : baseUrl = baseUrl ?? ApiConstants.baseUrl;

  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');

    try {
      _logger.d('POST Request to: $url');
      _logger.d('Request Body: ${jsonEncode(body)}');

      final response = await http
          .post(
            url,
            headers: {...ApiConstants.headers, ...?headers},
            body: jsonEncode(body),
          )
          .timeout(ApiConstants.timeout);

      _logger.d('Response Status: ${response.statusCode}');
      _logger.d('Response Body: ${response.body}');

      return _handleResponse(response);
    } catch (e) {
      _logger.e('API Error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    var url = Uri.parse('$baseUrl$endpoint');

    if (queryParameters != null && queryParameters.isNotEmpty) {
      url = url.replace(queryParameters: queryParameters);
    }

    try {
      _logger.d('GET Request to: $url');

      final response = await http
          .get(url, headers: {...ApiConstants.headers, ...?headers})
          .timeout(ApiConstants.timeout);

      _logger.d('Response Status: ${response.statusCode}');
      _logger.d('Response Body: ${response.body}');

      return _handleResponse(response);
    } catch (e) {
      _logger.e('API Error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');

    try {
      _logger.d('PUT Request to: $url');
      _logger.d('Request Body: ${jsonEncode(body)}');

      final response = await http
          .put(
            url,
            headers: {...ApiConstants.headers, ...?headers},
            body: jsonEncode(body),
          )
          .timeout(ApiConstants.timeout);

      _logger.d('Response Status: ${response.statusCode}');
      _logger.d('Response Body: ${response.body}');

      return _handleResponse(response);
    } catch (e) {
      _logger.e('API Error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> delete(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');

    try {
      _logger.d('DELETE Request to: $url');

      final response = await http
          .delete(url, headers: {...ApiConstants.headers, ...?headers})
          .timeout(ApiConstants.timeout);

      _logger.d('Response Status: ${response.statusCode}');
      _logger.d('Response Body: ${response.body}');

      return _handleResponse(response);
    } catch (e) {
      _logger.e('API Error: $e');
      rethrow;
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return {};
      }
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      String errorMessage = 'Request failed';

      try {
        final errorBody = jsonDecode(response.body);
        if (errorBody is Map<String, dynamic>) {
          errorMessage =
              errorBody['detail']?.toString() ??
              errorBody['message']?.toString() ??
              errorMessage;
        }
      } catch (e) {
        errorMessage = response.body.isNotEmpty
            ? response.body
            : 'Request failed with status: ${response.statusCode}';
      }

      throw ApiException(errorMessage, response.statusCode);
    }
  }
}
