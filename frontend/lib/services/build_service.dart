import 'dart:convert';
import 'package:frontend/services/auth_services.dart';
import 'package:frontend/services/userBuild.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BuildService {
  static const String baseUrl = 'http://10.0.2.2:8000/api/builds';

  Future<List<UserBuild>> getUserBuilds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken'); 

    final response = await http.get(
      Uri.parse('$baseUrl/index'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> buildsJson = json.decode(response.body);
      return buildsJson.map((json) => UserBuild.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load user builds: ${response.body}');
    }
  }

  Future<UserBuild> createUserBuild(UserBuild build) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');

    final response = await http.post(
      Uri.parse('$baseUrl/create'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(build.toJson()),
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      return UserBuild.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create user build: ${response.body}');
    }
  }
  Future<UserBuild> getUserBuildById(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken'); 

    final response = await http.get(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return UserBuild.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user build: ${response.body}');
    }
  }


}
