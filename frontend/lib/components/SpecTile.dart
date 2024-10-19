import 'package:flutter/material.dart';

Widget SpecTile(String specTitle, String specValue) {
  Widget specIcon;

  switch (specTitle) {
    case 'Motherboard':
      specIcon = Image.asset('lib/assets/icons/motherboard.png', width: 20, height: 20, color: Colors.cyan,);
      break;
    case 'GPU':
      specIcon = Image.asset('lib/assets/icons/gpu.png', width: 20, height: 20, color: Colors.cyan,);
      break;
    case 'RAM':
      specIcon = Image.asset('lib/assets/icons/ram.png', width: 20, height: 20, color: Colors.cyan,);
      break;
    case 'Storage':
      specIcon = Icon(Icons.storage, color: Colors.cyan, size: 20);
      break;
    case 'PSU':
      specIcon = Icon(Icons.power, color: Colors.cyan, size: 20);
      break;
    default:
      specIcon = Icon(Icons.memory, color: Colors.cyan, size: 20); 
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0), 
    child: Row(
      children: [
        specIcon, 
        SizedBox(width: 10),
        Expanded(
          child: Text(
            '$specTitle: $specValue',
            style: TextStyle(color: Colors.white),
            maxLines: 3, 
          ),
        ),
      ],
    ),
  );
}
