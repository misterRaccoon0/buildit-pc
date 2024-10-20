import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/components/userBuild_border.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuildPage extends StatefulWidget {
  const BuildPage({Key? key}) : super(key: key);

  @override
  _BuildPageState createState() => _BuildPageState();
}

class _BuildPageState extends State<BuildPage> {
  List _userBuilds = [];
  bool _isLoading = true;


  @override
  void initState() {
    super.initState();
    print('hello');
    _fetchBuilds();
  }

  Future<void> _fetchBuilds() async {
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
          _userBuilds = builds;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load builds');
      }
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
    title: ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          const Color.fromARGB(255, 4, 0, 255),
          const Color.fromARGB(255, 0, 140, 255),
          ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(
        'M Y   B U I L D S',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white, 
        ),
      ),
    ),
  ),


      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _userBuilds.isEmpty
              ? Center(child: Text("No builds available"))
              : ListView.builder(
                  itemCount: _userBuilds.length,
                  itemBuilder: (context, index) {
                    final build = _userBuilds[index];

                    final int? cpuId = build['cpu'] != null ? build['cpu']['id'] as int : null;
                    final int? gpuId = build['gpu'] != null ? build['gpu']['id'] as int : null;
                    final int? motherboardId = build['motherboard'] != null ? build['motherboard']['id'] as int : null;
                    final int? ramId = build['ram'] != null ? build['ram']['id'] as int : null;
                    final int? storageId = build['storage'] != null ? build['storage']['id'] as int : null;
                    final int? psuId = build['psu'] != null ? build['psu']['id'] as int : null;

                    return UserBuildBorder(
                      buildID: build['id'],
                      buildName: build['name'],
                      buildDescription: build['description'],
                      buildPic: NetworkImage('https://via.placeholder.com/150'), 

                      cpu: build['cpu'] != null 
                          ? '${build['cpu']['brand']} ${build['cpu']['name']} ${build['cpu']['model']}' 
                          : 'N/A',

                      gpu: build['gpu'] != null 
                          ? '${build['gpu']['brand']} ${build['gpu']['model']}' 
                          : 'N/A',
                          
                      motherboard: build['motherboard'] != null 
                          ? '${build['motherboard']['brand']} ${build['motherboard']['model']}' 
                          : 'N/A',

                      ram: build['ram'] != null 
                          ? build['ram']['model'] 
                          : 'N/A',

                      storage: build['storage'] != null 
                          ? '${build['storage']['brand']} ${build['storage']['model']}' 
                          : 'N/A',

                      psu: build['psu'] != null 
                          ? '${build['psu']['brand']} ${build['psu']['model']}' 
                          : 'N/A',

                      benchmarkScore: build['benchmarkScore'],
                          
                      dateCreated: 'Date not available', // wala pa 
                      
                      cpuId: cpuId,
                      gpuId: gpuId,
                      motherboardId: motherboardId,
                      ramId: ramId,
                      storageId: storageId,
                      psuId: psuId,
                    );
                  },
                ),
    );
  }
}
