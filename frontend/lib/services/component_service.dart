import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/components/component_selector.dart';

class ComponentService {
  static const String baseUrl = 'http://10.0.2.2:8000/api/component';

  Future<List<Component>> fetchCPU() async {
    final response = await http.get(Uri.parse('$baseUrl/cpu'));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((item) => Component(
        name: item['cpuName'],
        specs: item['specs'],
        price: item['price'] ?? 0,
        tdp: item['tdp'] ?? 0,
        imageUrl: 'https://via.placeholder.com/50', 
      )).toList();
    } else {
      throw Exception('Failed to load components');
    }
  }

  Future<List<Component>> fetchGPU() async {
    final response = await http.get(Uri.parse('$baseUrl/gpu'));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((item) => Component(
        name: item['gpuName'],
        specs: item['specs'],
        price: item['price'] ?? 0,
        tdp: item['tdp'] ?? 0,
        imageUrl: 'https://via.placeholder.com/50', 
      )).toList();

    } else {
      throw Exception('Failed to load components');
    }
  }

  Future<List<Component>> fetchMOBO() async {
    final response = await http.get(Uri.parse('$baseUrl/mobo'));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((item) => Component(
        name: item['moboName'],
        specs: item['specs'],
        price: item['price'] ?? 0,
        tdp: item['tdp'] ?? 0,
        imageUrl: 'https://via.placeholder.com/50', 
      )).toList();
      
    } else {
      throw Exception('Failed to load components');
    }
  }

  Future<List<Component>> fetchRAM() async {
    final response = await http.get(Uri.parse('$baseUrl/ram'));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((item) => Component(
        name: item['ramName'],
        specs: item['specs'],
        price: item['price'] ?? 0,
        tdp: item['tdp'] ?? 0,
        imageUrl: 'https://via.placeholder.com/50', 
      )).toList();
      
    } else {
      throw Exception('Failed to load components');
    }
  }

  Future<List<Component>> fetchSTORAGE() async {
    final response = await http.get(Uri.parse('$baseUrl/storage'));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((item) => Component(
        name: item['storageName'],
        specs: item['specs'],
        price: item['price'] ?? 0,
        tdp: item['tdp'] ?? 0,
        imageUrl: 'https://via.placeholder.com/50', 
      )).toList();
      
    } else {
      throw Exception('Failed to load components');
    }
  }

  Future<List<Component>> fetchPSU() async {
    final response = await http.get(Uri.parse('$baseUrl/psu'));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((item) => Component(
        name: item['psuName'],
        specs: item['specs'],
        price: item['price'] ?? 0,
        tdp: item['tdp'] ?? 0,
        imageUrl: 'https://via.placeholder.com/50', 
      )).toList();
      
    } else {
      throw Exception('Failed to load components');
    }
  }



}