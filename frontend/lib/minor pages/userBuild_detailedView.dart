import 'package:flutter/material.dart';
import 'package:frontend/minor%20pages/minor%20pages%20components/grid_tile_view.dart';
import 'package:frontend/minor%20pages/minor%20pages%20components/performance_bar.dart';
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
  });

  @override
  State<UserBuildDetailedView> createState() => _UserBuildDetailedViewState();
}

class _UserBuildDetailedViewState extends State<UserBuildDetailedView> {
  late Future<Map<String, dynamic>> _userProfile;

  void initState() {
    super.initState();
    _userProfile = fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {


    final Map<String, String> componentSpecs = { // SPECS PLACEHOLDER PLZ HELP ME FIX 
      "Cores": "8",
      "Threads": "16",
      "Base Clock": "3.6 GHz",
      "Boost Clock": "4.9 GHz",
    };


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
        backgroundColor: Colors.grey[300],
        title: Text(
          widget.buildName,
          style: TextStyle(fontWeight: FontWeight.bold),
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
              final ImageProvider userPic = NetworkImage(userProfile['profile_picture'] ?? 'https://via.placeholder.com/150'); 

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
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                  
            SizedBox(height: 8),
            Text(
              widget.buildDescription ?? 'No description available',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),


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
                      componentSpecs: componentSpecs,
                    );
                  case 1:
                    return GridTileView(
                      componentPic: NetworkImage('https://via.placeholder.com/100'),
                      componentTitle: 'GPU',
                      componentName: widget.gpu,
                      componentSpecs: componentSpecs,
                    );
                  case 2:
                    return GridTileView(
                      componentPic: NetworkImage('https://via.placeholder.com/100'),
                      componentTitle: 'Motherboard',
                      componentName: widget.motherboard,
                      componentSpecs: componentSpecs,
                    );
                  case 3:
                    return GridTileView(
                      componentPic: NetworkImage('https://via.placeholder.com/100'),
                      componentTitle: 'RAM',
                      componentName: widget.ram,
                      componentSpecs: componentSpecs,
                    );
                  case 4:
                    return GridTileView(
                      componentPic: NetworkImage('https://via.placeholder.com/100'),
                      componentTitle: 'Storage',
                      componentName: widget.storage,
                      componentSpecs: componentSpecs,
                    );
                  case 5:
                    return GridTileView(
                      componentPic: NetworkImage('https://via.placeholder.com/100'),
                      componentTitle: 'Power Supply',
                      componentName: widget.psu,
                      componentSpecs: componentSpecs,
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
                      fontSize: 20,
                      color: Color.fromARGB(255, 87, 87, 87),
                    ),
                  ),
                  //SizedBox(height: 8),
                  Text(
                    'S C O R E : $totalScore',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),


                  SizedBox(height: 10,),

                  Text(
                    'B U I L D   C A T E G O R Y',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 87, 87, 87),
                    ),
                  ),

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