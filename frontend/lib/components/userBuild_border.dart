import 'package:flutter/material.dart';
import 'package:frontend/minor%20pages/userBuild_detailedView.dart';

class userBuildBorder extends StatelessWidget {
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

  int? cpuId;
  int? gpuId;
  int? motherboardId;
  int? ramId;
  int? storageId;
  int? psuId;
  

  userBuildBorder({
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
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromARGB(255, 0, 12, 51),
          border: Border(
            top: BorderSide(color:const Color.fromARGB(255, 0, 255, 242)),
            left: BorderSide(color:const Color.fromARGB(255, 0, 255, 242)),
            right: BorderSide(color:const Color.fromARGB(255, 0, 255, 242)),
            bottom: BorderSide(color:const Color.fromARGB(255, 0, 255, 242)),
          )
          
          ),
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
              color:const Color.fromARGB(255, 0, 255, 242)
            ),
          ),
          subtitle: Text('Created: $dateCreated', style: TextStyle(color: Colors.white),),
          children: [
            ListTile(
              title: Text("CPU: $cpu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color:Colors.white
                ),),
            ),
            ListTile(
              title: Text("GPU: $gpu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color:Colors.white
                ),),
            ),
            ListTile(
              title: Text("Motherboard: $motherboard",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color:Colors.white
                ),),
            ),
            ListTile(
              title: Text("RAM: $ram",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color:Colors.white
                ),),
            ),
            ListTile(
              title: Text("Storage: $storage",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color:Colors.white
                ),),
            ),
            ListTile(
              title: Text("PSU: $psu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color:Colors.white
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
                        buildDescription: buildDescription,
                        benchmarkScore: benchmarkScore ?? 0,
                        dateCreated: dateCreated,
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
