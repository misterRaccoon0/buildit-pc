import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/services/user_profile.dart';
import 'package:frontend/minor%20pages/editProfile_page.dart';
import 'package:frontend/minor%20pages/shared_listView.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});


  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, dynamic>> _userProfile;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _userProfile = fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
      title: ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: [
            Color.fromARGB(255, 4, 0, 255),
            Color.fromARGB(255, 0, 140, 255),
            ],
          begin: Alignment.bottomLeft,
          end: Alignment.bottomRight,
        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
        child: const Text(
          'P R O F I L E',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white, 
          ),
        ),
      ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _userProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); 
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); 
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No profile data available')); 
          } else {
            final user = snapshot.data!;

            return SingleChildScrollView(
              
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  Center(
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!) 
                          : (user['image_url'] != null && user['image_url'].isNotEmpty)
                              ? NetworkImage('http://10.0.2.2:8000/' + user['image_url'])
                              : AssetImage('assets/images/placeholder.png') as ImageProvider, 
                      backgroundColor: Colors.grey[200],
                    ),
                  ),
                    
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        user['name'] ?? 'John Doe',
                        style:  TextStyle(
                          fontSize: 35,
                          //fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        user['email'] ?? 'john.doe@example.com',
                        style:  TextStyle(
                          fontSize: 15,
                          color: Colors.grey[900],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 3, 57, 139),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: Colors.grey[400]!,
                              width: 1,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 24,
                          ),
                        ),
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Divider(color: Colors.grey[400]),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        'S H A R E D   B U I L D S',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const SharedListView(itemCount: 5),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
