import 'package:flutter/material.dart';

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
              title: Text("CPU: $cpu"),
            ),
            ListTile(
              title: Text("GPU: $gpu"),
            ),
            ListTile(
              title: Text("Motherboard: $motherboard"),
            ),
            ListTile(
              title: Text("RAM: $ram"),
            ),
            ListTile(
              title: Text("Storage: $storage"),
            ),
            ListTile(
              title: Text("PSU: $psu"),
            ),
          ],
        ),
      ),
    );
  }
}
