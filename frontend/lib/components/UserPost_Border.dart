import 'package:flutter/material.dart';
import 'package:frontend/components/SpecTile.dart';

class UserPostBorder extends StatefulWidget {
  const UserPostBorder({Key? key}) : super(key: key);

  @override
  _UserPostBorderState createState() => _UserPostBorderState();
}

class _UserPostBorderState extends State<UserPostBorder> {
  bool isStarred = false; 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Color(0xFF1F1F1F), 
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.cyan,
            spreadRadius: 1,
            blurRadius: 0,
            //offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              CircleAvatar(
                backgroundColor: Colors.blueAccent,
                radius: 20.0,
                child: Icon(Icons.person, color: Colors.white),
              ),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Username',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.0),
          // Post Title
          Text(
            'Build Name', 
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 20.0),

          // Image Section
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white54, width: 2), 
            ),
            clipBehavior: Clip.hardEdge,
            child: AspectRatio(
              aspectRatio: 16 / 9, 
              child: FadeInImage.assetNetwork(
                placeholder: 'https://via.placeholder.com/150', 
                image: 'https://example.com/computer_build.jpg', 
                fit: BoxFit.cover, 
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.network('https://via.placeholder.com/150', fit: BoxFit.cover);
                },
              ),
            ),
          ),
          SizedBox(height: 20.0),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpecTile('CPU', 'Intel Core i9-11900k'),
              SpecTile('GPU', 'NVIDIA GeForce RTX 3080'),
              SpecTile('RAM', '32GB DDR4'),
              SpecTile('Storage', '1TB NVMe SSD'),
              SpecTile('Motherboard', 'ASUS ROG Strix Z590x'),
              SpecTile('PSU', 'Corsair RM850x'),
            ],
          ),
          SizedBox(height: 20.0),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             
              IconButton(
                onPressed: () {
                  setState(() {
                    isStarred = !isStarred; 
                  });
                },
                icon: Icon(
                  isStarred ? Icons.star : Icons.star_border, 
                  color: isStarred ? Colors.yellow : Colors.white, 
                  size: 20, // Set the icon size to smaller
                ),
                tooltip: 'Star',
              ),

              IconButton(
                onPressed: () {
                  
                },
                icon: Icon(Icons.comment, color: Colors.white, size: 20), 
                tooltip: 'Comment',
              ),
              
              IconButton(
                onPressed: () {
                  
                },
                icon: Icon(Icons.compare, color: Colors.white, size: 20), 
                tooltip: 'Compare',
              ),
            ],
          ),
        ],
      ),
    );
  }
}