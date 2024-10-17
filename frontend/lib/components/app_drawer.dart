import 'package:flutter/material.dart';
import 'package:frontend/services/user_profile.dart';

class AppDrawer extends StatelessWidget {
  final PageController pageController;

  const AppDrawer({
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
          final userImageUrl = userData['profile_image'] ?? 'https://via.placeholder.com/150'; 

          return Container(
            color: Colors.grey[800],
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(userImageUrl), 
                      ),
                      const SizedBox(height: 5),
                      Text(
                        userName, 
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        userEmail, 
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                
                ListTile(
                  leading: const Icon(Icons.account_circle, color: Colors.white, size: 40),
                  title: Text(
                    'P R O F I L E',
                    style: TextStyle(color: Colors.grey[100], fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    pageController.jumpToPage(3);
                  },
                ),
                Divider(color: Colors.grey[800]),
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.white, size: 40),
                  title: Text(
                    'A C C O U N T',
                    style: TextStyle(color: Colors.grey[100], fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  onTap: () {},
                ),
                Divider(color: Colors.grey[800]),
                ListTile(
                  leading: const Icon(Icons.build, color: Colors.white, size: 40),
                  title: Text(
                    'M Y  B U I L D S',
                    style: TextStyle(color: Colors.grey[100], fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    pageController.jumpToPage(1);
                  },
                ),
                Divider(color: Colors.grey[800]),
                ListTile(
                  leading: const Icon(Icons.question_mark_sharp, color: Colors.white, size: 40),
                  title: Text(
                    'H E L P',
                    style: TextStyle(color: Colors.grey[100], fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  onTap: () {},
                ),
                Divider(color: Colors.grey[800]),
                const SizedBox(height: 320),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.white, size: 40),
                  title: Text(
                    'L O G   O U T',
                    style: TextStyle(color: Colors.grey[100], fontWeight: FontWeight.bold, fontSize: 20),
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
