import 'dart:io';
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
        print(response.body);
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

    Future<void> updateProfile({
      required String name,
      required String email,
      String? imagePath,
    }) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('authToken');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.0.2.2:8000/api/profile/update'),
      );

      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      request.headers['Accept'] = 'application/json';

      request.fields['name'] = name;
      request.fields['email'] = email;

      if (imagePath != null && imagePath.isNotEmpty) {
        try {
          request.files.add(await http.MultipartFile.fromPath('image', imagePath));
        } catch (e) {
          print('Error adding image to request: $e');
          throw Exception('Failed to add image: $e');
        }
      }

      try {
        var response = await request.send();

        if (response.statusCode == 200) {

          var responseData = await response.stream.bytesToString();
          print('Profile updated successfully: $responseData');
          
        } else {
          var errorResponse = await response.stream.bytesToString();
          throw Exception('Failed to update profile: ${response.reasonPhrase}: $errorResponse');
        }
      } catch (e) {
        print('Error during profile update: $e');
        throw Exception('Error during profile update: $e');
      }


}







