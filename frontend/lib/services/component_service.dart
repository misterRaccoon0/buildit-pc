import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';  
import 'package:frontend/components/component_selector.dart';

class ComponentService {
  static const String baseUrl = 'http://10.0.2.2:8000/api/component';

  Future<List<Component>> fetchCPU() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');  
    
    final response = await http.get(
      Uri.parse('$baseUrl/cpu'),
      headers: {
        'Authorization': 'Bearer $token', 
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((item) => Component(
        id: item['id'],
        name: item['cpuName'],
        specs: item['specs'],
        price: item['price'] ?? 0,
        tdp: item['TDP'] ?? 0,
        imageUrl: 'https://via.placeholder.com/50', 
        socket: item['socket'] ?? '0',        
        gen: item['gen'] ?? '0',
        ramsupport: item['ramsupport'] ?? '0',
        benchmark: item['benchmark'] ?? 0,
      )).toList();
    } else {
      throw Exception('Failed to load components');
    }
  }

  Future<List<Component>> fetchGPU() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');  

    final response = await http.get(
      Uri.parse('$baseUrl/gpu'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((item) => Component(
        id: item['id'],
        name: item['gpuName'],
        specs: item['specs'],
        price: item['price'] ?? 0,
        tdp: item['tdp'] ?? 0,
        imageUrl: 'https://via.placeholder.com/50', 
        socket: item['socket'] ?? '0',        
        gen: item['gen'] ?? '0',
        ramsupport: item['ramsupport'] ?? '0',
        benchmark: item['benchmark'] ?? 0,
      )).toList();
    } else {
      throw Exception('Failed to load components');
    }
  }

  Future<List<Component>> fetchMOBO() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');  

    final response = await http.get(
      Uri.parse('$baseUrl/mobo'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((item) => Component(
        id: item['id'],
        name: item['moboName'],
        specs: item['specs'],
        price: item['price'] ?? 0,
        tdp: item['tdp'] ?? 0,
        imageUrl: 'https://via.placeholder.com/50',
        socket: item['socket'] ?? '0',        
        gen: item['gen'] ?? '0',
        ramsupport: item['ramsupport'] ?? '0',
        benchmark: item['benchmark'] ?? 0,     
      )).toList();
    } else {
      throw Exception('Failed to load components');
    }
  }

  Future<List<Component>> fetchRAM() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');  

    final response = await http.get(
      Uri.parse('$baseUrl/ram'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((item) => Component(
        id: item['id'],
        name: item['ramName'],
        specs: item['specs'],
        price: item['price'] ?? 0,
        tdp: item['tdp'] ?? 0,
        imageUrl: 'https://via.placeholder.com/50',
        socket: item['socket'] ?? '0',        
        gen: item['gen'] ?? '0',
        ramsupport: item['ramsupport'] ?? '0',
        benchmark: item['benchmark'] ?? 0,
      )).toList();
    } else {
      throw Exception('Failed to load components');
    }
  }

  Future<List<Component>> fetchSTORAGE() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');  

    final response = await http.get(
      Uri.parse('$baseUrl/storage'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((item) => Component(
        id: item['id'],
        name: item['storageName'],
        specs: item['specs'],
        price: item['price'] ?? 0,
        tdp: item['tdp'] ?? 0,
        imageUrl: 'https://via.placeholder.com/50', 
        socket: item['socket'] ?? '0',        
        gen: item['gen'] ?? '0',
        ramsupport: item['ramsupport'] ?? '0',
        benchmark: item['benchmark'] ?? 0,
      )).toList();
    } else {
      throw Exception('Failed to load components');
    }
  }

  Future<List<Component>> fetchPSU() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');  

    final response = await http.get(
      Uri.parse('$baseUrl/psu'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((item) => Component(
        id: item['id'],
        name: item['psuName'],
        specs: item['specs'],
        price: item['price'] ?? 0,
        tdp: item['tdp'] ?? 0,
        imageUrl: 'https://via.placeholder.com/50', 
        socket: item['socket'] ?? '0',        
        gen: item['gen'] ?? '0',
        ramsupport: item['ramsupport'] ?? '0',
        benchmark: item['benchmark'] ?? 0,
      )).toList();
    } else {
      throw Exception('Failed to load components');
    }
  }
}
