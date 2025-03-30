import 'dart:convert';
import 'package:http/http.dart' as http;

class API {

  // Allow direct testing by providing a flag
  static Future<String> callAPI(String endpoint, Map<String, dynamic> parameters, 
  {
    bool skipNative = false,
    String? token, // Add token parameter to the method
  }
  ) async {
    try {
      final apiHost = skipNative ? 'http://localhost:3000' : 'http://winbit.live';
      // Perform the actual HTTP request to localhost:3000
      final apiUrl = '$apiHost/$endpoint';
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token', // Add token to headers if it's provided
      };
      final body = jsonEncode(parameters);
      final httpResponse = await http.post(Uri.parse(apiUrl), headers: headers, body: body);
      if (httpResponse.statusCode == 200) {
        return httpResponse.body;
      } else {
        return 'Error: ${httpResponse.statusCode} - ${httpResponse.reasonPhrase}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
