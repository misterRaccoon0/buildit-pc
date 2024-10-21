import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:frontend/minor%20pages/minor%20pages%20components/BenchMarkBar.dart';
import 'package:frontend/minor%20pages/minor%20pages%20components/BuildCard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ComparePage extends StatefulWidget {
  final int buildID;
  final String buildName;
  final String? buildDescription;
  final ImageProvider buildPic;
  final String cpu;
  final String gpu;
  final String motherboard;
  final String ram;
  final String storage;
  final String psu;
  final int? benchmarkScore;
  final String dateCreated;

  final int? cpuBenchmark;
  final int? gpuBenchmark;

  final int? cpuId;
  final int? gpuId;
  final int? motherboardId;
  final int? ramId;
  final int? storageId;
  final int? psuId; 

  const ComparePage({
    super.key,
  required this.buildID,
    required this.buildName,
    this.buildDescription,
    required this.buildPic,
    required this.cpu,
    required this.gpu,
    required this.motherboard,
    required this.ram,
    required this.storage,
    required this.psu,
    this.benchmarkScore,
    required this.dateCreated,
    this.cpuId,
    this.gpuId,
    this.motherboardId,
    this.ramId,
    this.storageId,
    this.psuId,
    this.cpuBenchmark,
    this.gpuBenchmark, 
  });

  @override
  _ComparePageState createState() => _ComparePageState();
}

class _ComparePageState extends State<ComparePage> {
  String? selectedBuild1;
  String? selectedBuild2;
  List<dynamic> _savedBuilds = [];
  bool isLoading = true; 
  Map<String, dynamic>? build1Details;
  Map<String, dynamic>? build2Details;

  int build1CpuBenchmark = 0;
  int build1GpuBenchmark = 0;
  int build2CpuBenchmark = 0;
  int build2GpuBenchmark = 0;

  @override
  void initState() {
    super.initState();
    _fetchSavedBuilds();
  }

  Future<void> _fetchSavedBuilds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/builds/index'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List builds = json.decode(response.body);
        setState(() {
          _savedBuilds = builds;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load builds');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

Future<void> _fetchBuildDetails(String buildId, int buildNumber) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('authToken');

  try {
    print('Fetching build details for buildId: $buildId'); // Debug
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/builds/$buildId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final details = json.decode(response.body);
      print('Build details fetched: $details'); // Debug

      setState(() {
        if (buildNumber == 1) {
          build1Details = details;
        } else {
          build2Details = details;
        }
      });

      // Fetch CPU and GPU benchmarks
      try {
        final cpuId = details['cpu']?.toString(); // Convert CPU ID to String
        final gpuId = details['gpu']?.toString(); // Convert GPU ID to String

        if (cpuId != null && gpuId != null) {
          print('Fetching CPU benchmark for CPU ID: $cpuId'); // Debug
          final int cpuBenchmark = await _fetchCpuBenchmark(cpuId);
          print('CPU benchmark fetched: $cpuBenchmark'); // Debug

          print('Fetching GPU benchmark for GPU ID: $gpuId'); // Debug
          final int gpuBenchmark = await _fetchGpuBenchmark(gpuId);
          print('GPU benchmark fetched: $gpuBenchmark'); // Debug

          setState(() {
            if (buildNumber == 1) {
              build1CpuBenchmark = cpuBenchmark;
              build1GpuBenchmark = gpuBenchmark;
            } else {
              build2CpuBenchmark = cpuBenchmark;
              build2GpuBenchmark = gpuBenchmark;
            }
          });

          print('Benchmarks updated successfully in the state'); // Debug
        } else {
          print('Error: CPU or GPU ID is null');
        }
      } catch (e) {
        print('Error fetching benchmarks: $e');
      }
    } else {
      throw Exception('Failed to load build details');
    }
  } catch (e) {
    print('Error loading build details: $e');
  }
}

  void _showBuildSelectionDialog(BuildContext context, ValueChanged<String?> onSelected, int buildNumber) {
    String searchQuery = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select a Build'),
          content: SizedBox(
            width: double.maxFinite, 
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(hintText: 'Search builds...'),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView(
                    children: _savedBuilds
                        .where((build) => build['name'].toLowerCase().contains(searchQuery.toLowerCase()))
                        .map((build) {
                      return ListTile(
                        title: Text(build['name']),
                        onTap: () {
                          
                          onSelected(build['name']);
                          Navigator.of(context).pop();
                          
                          _fetchBuildDetails(build['id'].toString(), buildNumber);
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

Future<int> _fetchCpuBenchmark(String cpuId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('authToken');
  try {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/component/cpus/$cpuId'), 
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['benchmark']; 
    } else {
      throw Exception('Failed to load CPU benchmark');
    }
  } catch (e) {
    print(e);
    return 0; 
  }
}

Future<int> _fetchGpuBenchmark(String gpuId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('authToken');
  try {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/component/gpus/$gpuId'), 
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['benchmark']; 
    } else {
      throw Exception('Failed to load GPU benchmark');
    }
  } catch (e) {
    print(e);
    return 0; 
  }
}


    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              Color.fromARGB(255, 4, 0, 255),
              Color.fromARGB(255, 0, 140, 255),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: const Text(
            'C O M P A R E   B U I L D',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBuildSelectionDialog(context, (selectedBuild) {
                                setState(() {
                                  selectedBuild1 = selectedBuild;
                                });
                              }, 1);
                            },
                            child: Container(
                              width: 180,
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(color: Colors.blue, width: 2.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(selectedBuild1 ?? 'Select Build 1', style: const TextStyle(color: Colors.black)),
                                  const Icon(Icons.arrow_drop_down, color: Colors.blue),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              _showBuildSelectionDialog(context, (selectedBuild) {
                                setState(() {
                                  selectedBuild2 = selectedBuild;
                                });
                              }, 2);
                            },
                            child: Container(
                              width: 180,
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(color: Colors.blue, width: 2.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(selectedBuild2 ?? 'Select Build 2', style: const TextStyle(color: Colors.black)),
                                  const Icon(Icons.arrow_drop_down, color: Colors.blue),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildCard(build1Details, 1),
                        buildCard(build2Details, 2),
                      ],
                    ),
                    const SizedBox(height: 20),

                    
                    if (build1Details != null && build2Details != null) ...[
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'P E R F O R M A N C E',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      
                      benchmarkBar(
                        'Computing Performance',
                        build1CpuBenchmark ?? 0,
                        build2CpuBenchmark ?? 0,
                      ),

                      const SizedBox(height: 10),

                      
                      benchmarkBar(
                        'Rendering Performance',
                        build1GpuBenchmark ?? 0,
                        build2GpuBenchmark ?? 0,
                      ),

                      const SizedBox(height: 10),

                      
                      benchmarkBar(
                        'Overall Performance',
                        build1Details?['benchmarkScore'] ?? 0,
                        build2Details?['benchmarkScore'] ?? 0,
                      ),
                    ] else
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Select both builds to compare benchmarks'),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}