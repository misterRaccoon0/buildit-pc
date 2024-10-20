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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.blueAccent,
                radius: 20.0,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 10.0),
              const Text(
                'Username',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(width: 190),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'Profile') {
                    print("Profile selected");
                  } else if (value == 'Settings') {
                    print("Settings selected");
                  } else if (value == 'Logout') {
                    print("Logout selected");
                  }
                },
                itemBuilder: (BuildContext context) {
                  return {'Profile', 'Settings', 'Logout'}
                      .map((String choice) => PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          ))
                      .toList();
                },
                icon: const Icon(Icons.more_vert, color: Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 10.0),

          const Text(
            'Build Name',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height: 10.0),

          const Text(
            'description',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14.0,
            ),
          ),
          const SizedBox(height: 10.0),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
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
          const SizedBox(height: 10.0),

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
          const SizedBox(height: 20.0),

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
                  color: isStarred ? Colors.yellow[900] : Colors.blue[900],
                  size: 20,
                ),
                tooltip: 'Star',
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.comment, color: Colors.blue[900], size: 20),
                tooltip: 'Comment',
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.compare, color: Colors.blue[900], size: 20),
                tooltip: 'Compare',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
