import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:frontend/minor%20pages/minor%20pages%20components/BenchMarkBar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Widget buildCard(Map<String, dynamic>? buildDetails, int buildNumber) {
  
  Future<Map<String, dynamic>> fetchComponentDetails(String componentType, int componentId) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/component/$componentType/$componentId'),
      headers: {
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {'brand': 'N/A', 'name': 'N/A', 'model': 'N/A'};
    }
  }

  return Container(
    width: 180,
    height: 550,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.blue, width: 2.0),
    ),

    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                buildDetails?['name'] ?? 'No Build Selected',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          const SizedBox(height: 8),

          if (buildDetails != null) ...[
            // CPU
            FutureBuilder<Map<String, dynamic>>(
              future: fetchComponentDetails('cpus', buildDetails['cpu']),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ListTile(
                    leading: CircularProgressIndicator(),
                    title: Text('Loading CPU details...'),
                  );
                }
                if (snapshot.hasError) {
                  return const ListTile(
                    leading: Icon(Icons.error, color: Colors.red),
                    title: Text('Error loading CPU details'),
                  );
                }
                final cpu = snapshot.data ?? {};
                return ListTile(
                  leading: const Icon(Icons.memory, color: Color.fromARGB(255, 53, 58, 121)),
                  title: Text(
                    '${cpu['brand']} ${cpu['name']} ${cpu['model']}',
                    style: const TextStyle(fontSize: 15),
                  ),
                );
              },
            ),
            // GPU
            FutureBuilder<Map<String, dynamic>>(
              future: fetchComponentDetails('gpus', buildDetails['gpu']),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ListTile(
                    leading: CircularProgressIndicator(),
                    title: Text('Loading GPU details...'),
                  );
                }
                if (snapshot.hasError) {
                  return const ListTile(
                    leading: Icon(Icons.error, color: Colors.red),
                    title: Text('Error loading GPU details'),
                  );
                }
                final gpu = snapshot.data ?? {};
                return ListTile(
                  leading: Image.asset(
                    'lib/assets/icons/gpu.png',
                    width: 24,
                    height: 24,
                    color: const Color.fromARGB(255, 53, 58, 121),
                  ),
                  title: Text(
                    ' ${gpu['brand']} ${gpu['model']}',
                    style: const TextStyle(fontSize: 15),
                  ),
                );
              },
            ),
            // Motherboard
            FutureBuilder<Map<String, dynamic>>(
              future: fetchComponentDetails('motherboards', buildDetails['motherboard']),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ListTile(
                    leading: CircularProgressIndicator(),
                    title: Text('Loading Motherboard details...'),
                  );
                }
                if (snapshot.hasError) {
                  return const ListTile(
                    leading: Icon(Icons.error, color: Colors.red),
                    title: Text('Error loading Motherboard details'),
                  );
                }
                final motherboard = snapshot.data ?? {};
                return ListTile(
                  leading: Image.asset(
                    'lib/assets/icons/motherboard.png',
                    width: 24,
                    height: 24,
                    color: const Color.fromARGB(255, 53, 58, 121),
                  ),
                  title: Text(
                    '${motherboard['brand']} ${motherboard['model']}',
                    style: const TextStyle(fontSize: 15),
                  ),
                );
              },
            ),
            // RAM
            FutureBuilder<Map<String, dynamic>>(
              future: fetchComponentDetails('rams', buildDetails['ram']),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ListTile(
                    leading: CircularProgressIndicator(),
                    title: Text('Loading RAM details...'),
                  );
                }
                if (snapshot.hasError) {
                  return const ListTile(
                    leading: Icon(Icons.error, color: Colors.red),
                    title: Text('Error loading RAM details'),
                  );
                }
                final ram = snapshot.data ?? {};
                return ListTile(
                  leading: Image.asset(
                    'lib/assets/icons/ram.png',
                    width: 24,
                    height: 24,
                    color: const Color.fromARGB(255, 53, 58, 121),
                  ),                  title: Text(
                    '${ram['model']}',
                    style: const TextStyle(fontSize: 15),
                  ),
                );
              },
            ),
            // Storage
            FutureBuilder<Map<String, dynamic>>(
              future: fetchComponentDetails('storages', buildDetails['storage']),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ListTile(
                    leading: CircularProgressIndicator(),
                    title: Text('Loading Storage details...'),
                  );
                }
                if (snapshot.hasError) {
                  return const ListTile(
                    leading: Icon(Icons.error, color: Colors.red),
                    title: Text('Error loading Storage details'),
                  );
                }
                final storage = snapshot.data ?? {};
                return ListTile(
                  leading: const Icon(Icons.storage, color: Color.fromARGB(255, 53, 58, 121)),
                  title: Text(
                    '${storage['brand']} ${storage['model']}',
                    style: const TextStyle(fontSize: 15),
                  ),
                );
              },
            ),
            // PSU
            FutureBuilder<Map<String, dynamic>>(
              future: fetchComponentDetails('psus', buildDetails['psu']),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ListTile(
                    leading: CircularProgressIndicator(),
                    title: Text('Loading PSU details...'),
                  );
                }
                if (snapshot.hasError) {
                  return const ListTile(
                    leading: Icon(Icons.error, color: Colors.red),
                    title: Text('Error loading PSU details'),
                  );
                }
                final psu = snapshot.data ?? {};
                return ListTile(
                  leading: const Icon(Icons.power, color: Color.fromARGB(255, 53, 58, 121)),
                  title: Text(
                    '${psu['brand']} ${psu['model']}',
                    style: const TextStyle(fontSize: 15),
                  ),
                );
              },
            ),
          ] else
            const Text('Select a build to compare'),
        ],
      ),
    ),
  );
}
