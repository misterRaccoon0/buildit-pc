import 'package:flutter/material.dart';
import 'package:frontend/minor%20pages/minor%20pages%20components/grid_tile_view.dart';
import 'package:frontend/minor%20pages/minor%20pages%20components/performance_bar.dart';
import 'package:frontend/services/detailed_specs_service.dart';
import 'package:frontend/services/user_profile.dart';

class UserBuildDetailedView extends StatefulWidget {
  final int buildID;
  final String buildName;
  final ImageProvider buildPic;
  final String? buildDescription;
  final String cpu;
  final String gpu;
  final String motherboard;
  final String ram;
  final String storage;
  final String psu;
  final String dateCreated;
  final int benchmarkScore;

  final int? cpuId;
  final int? gpuId;
  final int? motherboardId;
  final int? ramId;
  final int? storageId;
  final int? psuId;
  

  UserBuildDetailedView({
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
    required this.dateCreated,
    required this.benchmarkScore,

    this.cpuId,
    this.gpuId,
    this.motherboardId,
    this.ramId,
    this.storageId,
    this.psuId,
  });

  @override
  State<UserBuildDetailedView> createState() => _UserBuildDetailedViewState();
}

class _UserBuildDetailedViewState extends State<UserBuildDetailedView> {
  late Future<Map<String, dynamic>> _userProfile;

  Map<String, String>? cpuSpecs;
  Map<String, String>? gpuSpecs;
  Map<String, String>? motherboardSpecs;
  Map<String, String>? ramSpecs;
  Map<String, String>? storageSpecs;
  Map<String, String>? psuSpecs;



  void initState() {
    super.initState();
    fetchAllComponentSpecs();
    _userProfile = fetchUserProfile();
  }

Future<void> fetchAllComponentSpecs() async {
  try {
    print("CPU ID: ${widget.cpuId}");
    print("GPU ID: ${widget.gpuId}");
    print("Motherboard ID: ${widget.motherboardId}");
    print("RAM ID: ${widget.ramId}");
    print("Storage ID: ${widget.storageId}");
    print("PSU ID: ${widget.psuId}");

    List<Future<void>> fetchFutures = [];

    if (widget.cpuId != null) {
      fetchFutures.add(fetchSpecsCPU(widget.cpuId!).then((specs) {
        cpuSpecs = specs;
        print("Fetched CPU specs: $cpuSpecs");
      }));
    }
    if (widget.gpuId != null) {
      fetchFutures.add(fetchSpecsGPU(widget.gpuId!).then((specs) {
        gpuSpecs = specs;
        print("Fetched GPU specs: $gpuSpecs");
      }));
    }
    if (widget.motherboardId != null) {
      fetchFutures.add(fetchSpecsMB(widget.motherboardId!).then((specs) {
        motherboardSpecs = specs;
        print("Fetched Motherboard specs: $motherboardSpecs");
      }));
    }
    if (widget.ramId != null) {
      fetchFutures.add(fetchSpecsRam(widget.ramId!).then((specs) {
        ramSpecs = specs;
        print("Fetched RAM specs: $ramSpecs");
      }));
    }
    if (widget.storageId != null) {
      fetchFutures.add(fetchSpecsStorage(widget.storageId!).then((specs) {
        storageSpecs = specs;
        print("Fetched Storage specs: $storageSpecs");
      }));
    }
    if (widget.psuId != null) {
      fetchFutures.add(fetchSpecsPSU(widget.psuId!).then((specs) {
        psuSpecs = specs;
        print("Fetched PSU specs: $psuSpecs");
      }));
    }

    await Future.wait(fetchFutures);

    setState(() {});

  } catch (e) {
    print("Error fetching specs: $e");
  }
}
  

  @override
  Widget build(BuildContext context) {

  // FIX 

    final int totalScore = widget.benchmarkScore;
    String performanceLevel;
    if (totalScore < 30000) {
      performanceLevel = "Entry-level";
    } else if (totalScore < 120000) {
      performanceLevel = "Mid-range";
    } else {
      performanceLevel = "High-end";
    }


    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: BackButton(color: Colors.black,),
        backgroundColor: Colors.white,
        title: ShaderMask(
           shaderCallback: (bounds) => LinearGradient(
        colors: [
          const Color.fromARGB(255, 4, 0, 255),
          const Color.fromARGB(255, 0, 140, 255),
          ],
        begin: Alignment.bottomLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: Text(
            widget.buildName,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),


        body: FutureBuilder<Map<String, dynamic>>(
          future: _userProfile, 
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator()); 
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}')); 
            } else if (snapshot.hasData) {
              final userProfile = snapshot.data!;
              final String userName = userProfile['name'] ?? 'Unknown User'; 
              final ImageProvider userPic = NetworkImage(userProfile['profile_picture'] ?? 'https:svia.placeholder.com/150'); 

              return SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: userPic, 
                        ),
                        SizedBox(width: 10),
                        Text(
                          userName, 
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.blue[800]),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: widget.buildPic,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1.5),
                      borderRadius: BorderRadius.circular(12.0),
                      color: Color.fromARGB(255, 67, 85, 146),
                    ),
                    child: Text(
                      widget.buildDescription ?? 'No description available',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),


            SizedBox(height: 16),
            Text('B U I L D   S P E C S :', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[900]),),


            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: .6, 
              ),
              itemCount: 6, 
              shrinkWrap: true, 
              physics: NeverScrollableScrollPhysics(), 
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return GridTileView(
                      componentPic: NetworkImage('https://via.placeholder.com/100'), // palitan 
                      componentTitle: 'CPU',
                      componentName: widget.cpu,
                      componentSpecs: cpuSpecs ?? {"Loading": "..."},
                    );
                  case 1:
                    return GridTileView(
                      componentPic: NetworkImage('https://via.placeholder.com/100'),
                      componentTitle: 'GPU',
                      componentName: widget.gpu,
                      componentSpecs: gpuSpecs ?? {"Loading": "..."},
                    );
                  case 2:
                    return GridTileView(
                      componentPic: NetworkImage('https://via.placeholder.com/100'),
                      componentTitle: 'Motherboard',
                      componentName: widget.motherboard,
                      componentSpecs:  motherboardSpecs ?? {"Loading": "..."} ,
                    );
                  case 3:
                    return GridTileView(
                      componentPic: NetworkImage('https://via.placeholder.com/100'),
                      componentTitle: 'RAM',
                      componentName: widget.ram,
                      componentSpecs: ramSpecs ?? {"Loading": "..."},
                    );
                  case 4:
                    return GridTileView(
                      componentPic: NetworkImage('https://via.placeholder.com/100'),
                      componentTitle: 'Storage',
                      componentName: widget.storage,
                      componentSpecs: storageSpecs ?? {"Loading": "..."},
                    );
                  case 5:
                    return GridTileView(
                      componentPic: NetworkImage('https://via.placeholder.com/100'),
                      componentTitle: 'Power Supply',
                      componentName: widget.psu,
                      componentSpecs: psuSpecs ?? {"Loading": "..."},
                    );
                  default:
                    return Container();
                }
              },
            ),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'P E R F O R M A N C E :',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.blue [900],
                    ),
                  ),
                  //SizedBox(height: 8),
                  Text(
                    'S C O R E : $totalScore',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 1, 61, 110)),
                  ),


                  SizedBox(height: 10,),

                  Text(
                    'B U I L D   C A T E G O R Y',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),

                  SizedBox(height: 10,),

                  Center(
                    child: PerformanceBar(
                      totalScore: totalScore, 
                      performanceLevel: performanceLevel
                      ),
                  ),

                  ]
                )
              )
            ]
          )
        );
      }
        return Center(child: Text('No data available'));}
      )
    );
  }
}