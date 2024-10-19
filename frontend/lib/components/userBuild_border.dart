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

  final int? cpuId;
  final int? gpuId;
  final int? motherboardId;
  final int? ramId;
  final int? storageId;
  final int? psuId;
  

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
          color:Colors.white,
          border: Border.all(
            color: Colors.white,
            width: 2
          ),
          boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 89, 255).withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
          
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
              color:const Color.fromARGB(255, 52, 51, 128)
            ),
          ),
          subtitle: Text('Created: $dateCreated', style: TextStyle(color: Colors.grey[700]),),
          children: [
          ListTile(
            leading: Icon(Icons.memory, color:  const Color.fromARGB(255, 53, 58, 121)), 
            title: Text(
              "CPU: $cpu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
              leading: Image.asset(
                'lib/assets/icons/gpu.png',
                width: 24,
                height: 24,
                color: const Color.fromARGB(255, 53, 58, 121),
              ), 
            title: Text(
              "GPU: $gpu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            leading: Image.asset(
              'lib/assets/icons/motherboard.png',
              width: 24,
              height: 24,
              color:  const Color.fromARGB(255, 53, 58, 121),
            ),
            title: Text(
              "Motherboard: $motherboard",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
          leading: Image.asset(
            'lib/assets/icons/ram.png',
            width: 24,
            height: 24,
            color:  const Color.fromARGB(255, 53, 58, 121),
          ),
            title: Text(
              "RAM: $ram",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.storage, color:  const Color.fromARGB(255, 53, 58, 121)), 
            title: Text(
              "Storage: $storage",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.power, color:  const Color.fromARGB(255, 53, 58, 121)), 
            title: Text(
              "PSU: $psu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: (){
                   print("Build ID: $buildID");
                   print("cpuID: $cpuId");
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

                        cpuId: cpuId,
                        gpuId: gpuId,
                        motherboardId: motherboardId,
                        ramId: ramId,
                        storageId: storageId,
                        psuId: psuId,
                        )
                        )
                        );
                }, 
                child: Text('Detailed View',
                style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[500]
                ),
                ),
            )
          ],
        ),
      ),
    );
  }
}
