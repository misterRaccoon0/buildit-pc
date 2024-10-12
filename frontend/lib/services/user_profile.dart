import 'package:shared_preferences/shared_preferences.dart';  
import 'dart:convert';
import 'package:http/http.dart' as http;
  
  Future<Map<String, dynamic>> fetchUserProfile() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('authToken');  

      if (token == null) {
        throw Exception('Token not found. Please log in.');
      }

      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized. Please log in again.');
      } else {
        print('Failed to load profile. Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        throw Exception(
          'Failed to load profile. Status code: ${response.statusCode}, body: ${response.body}',
        );
      }
    } catch (error) {
      print('Error fetching profile: ${error.toString()}');
      throw Exception('Error fetching profile: ${error.toString()}');
    }
  }

