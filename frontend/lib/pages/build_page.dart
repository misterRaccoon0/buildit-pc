import 'package:flutter/material.dart';
import 'package:frontend/components/userBuild_border.dart';


class BuildPage extends StatefulWidget {
  const BuildPage({ Key? key }) : super(key: key);

  @override
  _BuildPageState createState() => _BuildPageState();
}

class _BuildPageState extends State<BuildPage> {

  final List _userBuilds = [
    'test',
    'test',
    'test',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.grey[300],
    appBar: AppBar(
    title: Text( 'M Y   B U I L D S',
    style: TextStyle(fontWeight: FontWeight.bold),
    ),
    automaticallyImplyLeading: false,
    backgroundColor: Colors.grey[300],
  ),

    body: ListView.builder(
      itemCount: _userBuilds.length,
      itemBuilder: (context, index) {
        return userBuildBorder(
          buildID: 1,
          buildName: 'buildName', 
          buildPic: NetworkImage('https://via.placeholder.com/150'), // buildPic placeholder 
          cpu: 'cpu', 
          gpu: 'gpu', 
          motherboard: 'motherboard', 
          ram: 'ram', 
          storage: 'storage', 
          psu: 'psu', 
          dateCreated: 'dateCreated'
          );
        }
      ),
    );
  }
}