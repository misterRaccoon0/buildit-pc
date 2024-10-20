import 'package:flutter/material.dart';

Widget SpecTile(String specTitle, String specValue) {
  Widget specIcon;

  switch (specTitle) {
    case 'Motherboard':
      specIcon = Image.asset(
        'lib/assets/icons/motherboard.png',
        width: 20,
        height: 20,
        color: Colors.blue[800], 
      );
      break;
    case 'GPU':
      specIcon = Image.asset(
        'lib/assets/icons/gpu.png',
        width: 20,
        height: 20,
        color: Colors.blue[800], 
      );
      break;
    case 'RAM':
      specIcon = Image.asset(
        'lib/assets/icons/ram.png',
        width: 20,
        height: 20,
        color: Colors.blue[800], 
      );
      break;
    case 'Storage':
      specIcon = Icon(
        Icons.storage,
        color: Colors.blue[800], 
        size: 20,
      );
      break;
    case 'PSU':
      specIcon = Icon(
        Icons.power,
        color: Colors.blue[800], 
        size: 20,
      );
      break;
    default:
      specIcon = Icon(
        Icons.memory,
        color: Colors.blue[800], 
        size: 20,
      );
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      children: [
        specIcon,
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            '$specTitle: $specValue',
            style: const TextStyle(
              color: Colors.black, 
              fontWeight: FontWeight.bold, 
            ),
            maxLines: 3,
          ),
        ),
      ],
    ),
  );
}
