import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:iezepay_sdk_v1/api.dart';
void main() {


  test('Signup API call test==>', () async {
    // Call API directly, bypassing MethodChannel
    final response = await API.callAPI('signup', {
      'username': 'galaxy@example.com',
      'password': 'p@@@ssword23!@####'
    }, skipNative: true);  // Bypass native call

    print('Response from API: $response');

    // Expect response to contain valid data
    expect(response.isNotEmpty, true);
    // ✅ Decode the response into a Dart Map
    final Map<String, dynamic> jsonResponse = jsonDecode(response);

    expect(jsonResponse["message"], "User registered successfully");
    expect(jsonResponse, contains('token'));  // Assuming API returns {"status": "..."}
  }, skip: true);


  test('Login API call test Bad credentials==>', () async {
    // Call API directly, bypassing MethodChannel
    final response = await API.callAPI('login', {
      'username': 'sun1@example.com',
      'password': 'p1@@@ssword23'
    }, skipNative: true);  // Bypass native call

    print('Response from API: $response');
    // Expect response to contain valid data
    expect(response, contains("Error: 404 - Not Found"));
    
  }, skip: true);


  test('Login API call test==>', () async {
    // Call API directly, bypassing MethodChannel
    final response = await API.callAPI('login', {
      'username': 'sun@example.com',
      'password': 'p@@@ssword23'
    }, skipNative: true);  // Bypass native call

    print('Response from API: $response');

    // Expect response to contain valid data
    expect(response.isNotEmpty, true);
    // ✅ Decode the response into a Dart Map
    final Map<String, dynamic> jsonResponse = jsonDecode(response);

    expect(jsonResponse["message"], "Login successful");
    expect(jsonResponse, contains('token'));  // Assuming API returns {"status": "..."}
  });


  test('Dashboard API call test==>', () async {
    // Call API directly, bypassing MethodChannel
    final response = await API.callAPI('login', {
      'username': 'galaxy@example.com',
      'password': 'p@@@ssword23!@####'
    }, skipNative: true);  // Bypass native call

    print('Response from API: $response');

    // Expect response to contain valid data
    expect(response.isNotEmpty, true);
    // ✅ Decode the response into a Dart Map
    final Map<String, dynamic> jsonResponse = jsonDecode(response);

    expect(jsonResponse["message"], "Login successful");
    expect(jsonResponse, contains('token'));  // Assuming API returns {"status": "..."}
    // Extract token from login response
    final String token = jsonResponse['token'];

    // Now, call the Dashboard API using the token
    final dashboardResponse = await API.callAPI('dashboard', {}, skipNative: true, token: token);
    print('Dashboard Response: $dashboardResponse');
    
    // Expect the dashboard response to be valid and contain expected data
    expect(dashboardResponse.isNotEmpty, true);
    final Map<String, dynamic> dashboardJsonResponse = jsonDecode(dashboardResponse);
      
  // Expect message from the dashboard API
      expect(dashboardJsonResponse["message"], "Welcome to your Dashboard!");
      expect(dashboardJsonResponse["username"], "galaxy@example.com");  // Assuming username is in the response
      expect(dashboardJsonResponse['stats'], isNotNull);
      expect(dashboardJsonResponse['stats']['trades'], isNonNegative);
      expect(dashboardJsonResponse['stats']['balance'], isNonNegative);
      expect(dashboardJsonResponse['stats']['predictedTrades'], isNonNegative);
  
  });


}