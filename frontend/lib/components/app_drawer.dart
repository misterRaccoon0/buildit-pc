import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/services/user_profile.dart';

class AppDrawer extends StatelessWidget {
  final PageController pageController;
  File? _imageFile;

  AppDrawer({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<Map<String, dynamic>>(
        future: fetchUserProfile(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); 
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); 
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found')); 
          }

          final userData = snapshot.data!;
          final userName = userData['name'] ?? 'User'; 
          final userEmail = userData['email'] ?? 'user@example.com';
          //final userImageUrl = 'http://10.0.2.2:8000/' + (userData['profile_image'] ?? 'storage/images/profile/default.png'); 

          return Container(
            color: Colors.grey[350], // DRAWER BG
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 18, 41, 104), // USER INFO PANEL
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!) 
                              : (userData['image_url'] != null && userData['image_url'].isNotEmpty
                                  ? NetworkImage('http://10.0.2.2:8000/' + userData['image_url']) 
                                  : AssetImage('assets/images/placeholder.png') 
                                ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Center(
                        child: Text(
                          userName, 
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 255, 242),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          userEmail, 
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 255, 242),
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                ListTile(
                  leading:  Icon(Icons.account_circle, color: Colors.blue[900], size: 40),
                  title: const Text(
                    'P R O F I L E',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    pageController.jumpToPage(3);
                  },
                ),
                Divider(color: Colors.grey[350]),
                ListTile(
                  leading:  Icon(Icons.settings, color: Colors.blue[900], size: 40),
                  title: const Text(
                    'A C C O U N T',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  onTap: () {},
                ),
                Divider(color:Colors.grey[350]),
                ListTile(
                  leading:  Icon(Icons.build, color: Colors.blue[900], size: 40),
                  title: const Text(
                    'M Y  B U I L D S',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    pageController.jumpToPage(1);
                  },
                ),
                Divider(color: Colors.grey[350]),
                ListTile(
                  leading:  Icon(Icons.question_mark_sharp, color: Colors.blue[900], size: 40),
                  title: const Text(
                    'H E L P',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  onTap: () {},
                ),
                Divider(color:Colors.grey[350]),
                const SizedBox(height: 320),
                ListTile(
                  leading:  Icon(Icons.logout, color: Colors.blue[900], size: 40),
                  title: const Text(
                    'L O G   O U T',
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
