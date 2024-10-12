import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

String? sessionCookie;

class AuthService {
  final String baseUrl = 'http://10.0.2.2:8000/api/user'; 



  Future<String> registerUser(String name, String email, String password) async {
    var url = Uri.parse('$baseUrl/register');
    
    Map<String, String> jsonBody = {
      'name': name,
      'email': email,
      'password': password,
    };

    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(jsonBody),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return 'OK';
      } else {
        return response.body;
      }
    } catch (e) {
      print(e.toString());
      return 'An error occurred. Please try again.';
    }
  }


  Future<String?> loginUser(String email, String password) async {
        final url = Uri.parse('$baseUrl/login'); 

        Map<String, String> jsonBody = {
            'email': email,
            'password': password,
        };

        try {
            final response = await http.post(
                url,
                headers: {'Content-Type': 'application/json'},
                body: json.encode(jsonBody),
            );

            print('Response status: ${response.statusCode}');
            print('Response body: ${response.body}');

            if (response.statusCode == 200) {
                
                var data = json.decode(response.body);
                String token = data['access_token'];  
                return token; 
            } else {
                
                var errorData = json.decode(response.body);
                return null; 
            }
        } catch (e) {
            print(e.toString());
            return null; 
        }
    }
}





