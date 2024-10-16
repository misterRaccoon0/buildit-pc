import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailedSpecs {
  final String apiUrl = 'http://10.0.2.2:8000/api';  

  Future<Map<String, String>> fetchBuildDetails(int buildId) async {
    final response = await http.get(Uri.parse('$apiUrl/builds/$buildId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        "cpuId": data["cpu"].toString(),
        "gpuId": data["gpu"].toString(),
        "moboId": data["motherboard"].toString(),
        "ramId": data["ram"].toString(),
        "storageId": data["storage"].toString(),
        "psuId": data["psu"].toString(),
      };
    } else {
      throw Exception('Failed to load build details');
    }
  }

  Future<Map<String, String>> fetchCpuSpecs(int cpuId) async {
    final response = await http.get(Uri.parse('$apiUrl/components/cpu/$cpuId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        "Cores": data["cores"].toString(),
        "Threads": data["threads"].toString(),
        "Base Clock": data["base_clock"].toString(),
        "Boost Clock": data["boost_clock"].toString(),
      };
    } else {
      throw Exception('Failed to load CPU specs');
    }
  }

  Future<Map<String, String>> fetchGpuSpecs(int gpuId) async {
    final response = await http.get(Uri.parse('$apiUrl/components/gpu/$gpuId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        "VRAM": data["vram"].toString(),
        "Clock": data["clock"].toString(),
        "Memory Clock": data["memory_clock"].toString(),
        "BUS": data["bus"].toString(),
      };
    } else {
      throw Exception('Failed to load GPU specs');
    }
  }

  Future<Map<String, String>> fetchMotherboardSpecs(int moboId) async {
    final response = await http.get(Uri.parse('$apiUrl/components/motherboard/$moboId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        "Socket": data["socket"].toString(),
        "Chipset": data["chipset"].toString(),
        "Ram Support": data["ram_support"].toString(),
        "Storage Interface": data["storage_interface"].toString(),
      };
    } else {
      throw Exception('Failed to load Motherboard specs');
    }
  }

  Future<Map<String, String>> fetchRamSpecs(int ramId) async {
    final response = await http.get(Uri.parse('$apiUrl/components/ram/$ramId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        "Size": data["size"].toString(),
        "Speed": data["speed"].toString(),
        "Generation": data["generation"].toString(),
        "CL": data["cl"].toString(),
      };
    } else {
      throw Exception('Failed to load RAM specs');
    }
  }

  Future<Map<String, String>> fetchStorageSpecs(int storageId) async {
    final response = await http.get(Uri.parse('$apiUrl/components/storage/$storageId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        "Size": data["size"].toString(),
        "Read Speed": data["read_speed"].toString(),
        "Write Speed": data["write_speed"].toString(),
        "Interface": data["interface"].toString(),
      };
    } else {
      throw Exception('Failed to load Storage specs');
    }
  }

  Future<Map<String, String>> fetchPsuSpecs(int psuId) async {
    final response = await http.get(Uri.parse('$apiUrl/components/psu/$psuId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        "Watts": data["watts"].toString(),
        "Rating": data["rating"].toString(),
      };
    } else {
      throw Exception('Failed to load PSU specs');
    }
  }
}
