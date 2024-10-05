import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';  
import 'package:frontend/components/component_selector.dart';

Future<Map<String, String>> fetchSpecsCPU(int cpu) async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/component/cpus/$cpu'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final specsCPU = data['specs']; 

    return {
      "Cores": specsCPU['cores'],
      "Threads": specsCPU['threads'],
      "Clockspeed": specsCPU['clockspeed'],
      "Socket": specsCPU['socket'],
    };
  } else {
    throw Exception('Failed to load component specs');
  }
}
