import 'package:flutter/material.dart';
import 'package:frontend/minor%20pages/minor%20pages%20components/grid_tile_view.dart';

class UserBuildDetailedView extends StatelessWidget {
  final int buildID;
  final String buildName;
  final ImageProvider buildPic;
  final String cpu;
  final String gpu;
  final String motherboard;
  final String ram;
  final String storage;
  final String psu;
  final String dateCreated;

  UserBuildDetailedView({
    required this.buildID,
    required this.buildName,
    required this.buildPic,
    required this.cpu,
    required this.gpu,
    required this.motherboard,
    required this.ram,
    required this.storage,
    required this.psu,
    required this.dateCreated,
  });

  @override
  Widget build(BuildContext context) {
    // Placeholders for user info
    final String userName = "John Doe";
    final ImageProvider userPic = NetworkImage('https://via.placeholder.com/150');

    final Map<String, String> componentSpecs = {
      "Cores": "8",
      "Threads": "16",
      "Base Clock": "3.6 GHz",
      "Boost Clock": "4.9 GHz",
    };

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text(
          buildName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
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
                  image: buildPic,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8),
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
                      componentPic: NetworkImage('https://via.placeholder.com/100'),
                      componentTitle: 'CPU',
                      componentName: cpu,
                      componentSpecs: componentSpecs,
                    );
                  case 1:
                    return GridTileView(
                      componentPic: NetworkImage('https://via.placeholder.com/100'),
                      componentTitle: 'GPU',
                      componentName: gpu,
                      componentSpecs: componentSpecs,
                    );
                  case 2:
                    return GridTileView(
                      componentPic: NetworkImage('https://via.placeholder.com/100'),
                      componentTitle: 'Motherboard',
                      componentName: motherboard,
                      componentSpecs: componentSpecs,
                    );
                  case 3:
                    return GridTileView(
                      componentPic: NetworkImage('https://via.placeholder.com/100'),
                      componentTitle: 'RAM',
                      componentName: ram,
                      componentSpecs: componentSpecs,
                    );
                  case 4:
                    return GridTileView(
                      componentPic: NetworkImage('https://via.placeholder.com/100'),
                      componentTitle: 'Storage',
                      componentName: storage,
                      componentSpecs: componentSpecs,
                    );
                  case 5:
                    return GridTileView(
                      componentPic: NetworkImage('https://via.placeholder.com/100'),
                      componentTitle: 'Power Supply',
                      componentName: psu,
                      componentSpecs: componentSpecs,
                    );
                  default:
                    return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
