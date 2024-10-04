import 'package:flutter/material.dart';
import 'package:frontend/minor%20pages/userBuild_detailedView.dart';

class userBuildBorder extends StatelessWidget {
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

  userBuildBorder({
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        child: ExpansionTile(
          leading: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: buildPic,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          title: Text(buildName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text('Created: $dateCreated'),
          children: [
            ListTile(
              title: Text("CPU: $cpu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15
                ),),
            ),
            ListTile(
              title: Text("GPU: $gpu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15
                ),),
            ),
            ListTile(
              title: Text("Motherboard: $motherboard",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15
                ),),
            ),
            ListTile(
              title: Text("RAM: $ram",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15
                ),),
            ),
            ListTile(
              title: Text("Storage: $storage",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15
                ),),
            ),
            ListTile(
              title: Text("PSU: $psu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15
                ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: (){

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserBuildDetailedView(
                        buildID: buildID, 
                        buildName: buildName, 
                        buildPic: buildPic, 
                        cpu: cpu, 
                        gpu: gpu, 
                        motherboard: motherboard, 
                        ram: ram, 
                        storage: storage, 
                        psu: psu, 
                        dateCreated: dateCreated
                        )
                        )
                        );
                }, 
                child: Text('Detailed View',
                style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[600]
                ),
                ),
            )
          ],
        ),
      ),
    );
  }
}
