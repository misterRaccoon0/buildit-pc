import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, String>> fetchSpecsCPU(int cpuId) async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/component/cpus/$cpuId'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print("Full CPU API Response: $data");  

    return {
      "Cores": data['cores'].toString(),  
      "Threads": data['threads'].toString(),
      "Clockspeed": data['clockspeed'].toString(),
      "Socket": data['socket'].toString(),
    };
  } else {
    throw Exception('Failed to load CPU specs');
  }
}


Future<Map<String, String>> fetchSpecsGPU(int gpuId) async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/component/gpus/$gpuId'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print("Full GPU API Response: $data");  
    return {
      "VRAM": data['vram'].toString(),
      "Clock": data['clock'].toString(),
      "MemClock": data['memoryclock'].toString(),
      "BUS": data['bus'].toString(),
    };
  } else {
    throw Exception('Failed to load GPU specs');
  }
}


Future<Map<String, String>> fetchSpecsMB(int motherboardId) async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/component/motherboards/$motherboardId'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print("Full Motherboard API Response: $data"); 

    return {
      "Socket": data['socket'].toString(),
      "Chipset": data['chipset'].toString(),
      "RAM": data['ramsupport'].toString(),
      "Storage": data['storageinterface'].toString(),
    };
  } else {
    throw Exception('Failed to load Motherboard specs');
  }
}



Future<Map<String, String>> fetchSpecsRam(int ramId) async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/component/rams/$ramId'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print("Full RAM API Response: $data");  
    return {
      "Size": data['size'].toString(),
      "Speed": data['speed'].toString(),
      "Generation": data['gen'].toString(),
      "CL": data['cl'].toString(),
    };
  } else {
    throw Exception('Failed to load RAM specs');
  }
}


Future<Map<String, String>> fetchSpecsStorage(int storageId) async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/component/storages/$storageId'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print("Full Storage API Response: $data"); 
    
    // Access unit_size correctly
    String unitSize = data['unitsize']; 

    return {
      "Size": '${data['size']} $unitSize', 
      "Interface": data['interface'].toString(),
      "Read": data['readspeed'].toString(),
      "Write": data['writespeed'].toString(),
    };
  } else {
    throw Exception('Failed to load Storage specs');
  }
}

Future<Map<String, String>> fetchSpecsPSU(int psuId) async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/component/psus/$psuId'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print("Full PSU API Response: $data");  

    return {
      "Brand": data['brand'].toString(),
      "Model": data['model'].toString(),
      "Watts": data['watts'].toString(),
      "Rating": data['rating'].toString(),
    };
  } else {
    throw Exception('Failed to load PSU specs');
  }
}

