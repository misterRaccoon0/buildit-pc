import 'dart:convert';
import 'package:frontend/services/userBuild.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:path/path.dart';


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

/*   Future<UserBuild> createUserBuild(UserBuild build) async {
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
  } */


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

  Future<void> deleteUserBuild(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken'); 

    final response = await http.delete(
      Uri.parse('$baseUrl/delete/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete user build: ${response.body}');
    } else {
      print('Build deleted successfully');
    }
  }

  Future<void> editUserBuild(int buildID, {String? name, String? description, File? imageFile}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');

    // Create a MultipartRequest
    var request = http.MultipartRequest('POST', Uri.parse('http://10.0.2.2:8000/api/builds/edit/$buildID'));
    request.headers['Authorization'] = 'Bearer $token';

    // Add the fields
    if (name != null) {
      request.fields['name'] = name;
    }
    if (description != null) {
      request.fields['description'] = description;
    }
    
    if (imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath('image_url', imageFile.path));
    }

    var response = await request.send();
    
    final responseBody = await http.Response.fromStream(response);
    print('Response status: ${responseBody.statusCode}');
    print('Response body: ${responseBody.body}');

    if (responseBody.statusCode != 200) {
      throw Exception('Failed to edit build: ${responseBody.body}');
    }
  }

  Future<void> createUserBuild(UserBuild build, File? imageFile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken'); 

    var uri = Uri.parse('http://10.0.2.2:8000/api/builds/create');
    var request = http.MultipartRequest('POST', uri);

    request.headers['Authorization'] = 'Bearer $token'; 
    request.headers['Content-Type'] = 'multipart/form-data';

    request.fields['name'] = build.name;
    request.fields['description'] = build.description!;
    request.fields['cpu'] = build.cpu.toString();
    request.fields['gpu'] = build.gpu.toString();
    request.fields['motherboard'] = build.motherboard.toString();
    request.fields['ram'] = build.ram.toString();
    request.fields['storage'] = build.storage.toString();
    request.fields['psu'] = build.psu.toString();
    request.fields['totalTdp'] = build.totalTdp.toString();
    request.fields['totalPrice'] = build.totalPrice.toString();
    request.fields['benchmarkScore'] = build.benchmarkScore.toString();
    request.fields['user_id'] = build.user_id.toString();

    if (imageFile != null) {
      var stream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile(
        'image_url',
        stream,
        length,
        filename: basename(imageFile.path),
      );
      request.files.add(multipartFile);
    }

    var response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Build uploaded successfully');
    } else {
      print('Failed to upload build. Status code: ${response.statusCode}');
      throw Exception('Failed to upload build');
    }
  }
}











