import 'package:flutter/material.dart';
import 'package:frontend/services/user_profile.dart';

class AppDrawer extends StatelessWidget {
  final PageController pageController;

  const AppDrawer({
    Key? key,
    required this.pageController,
  }) : super(key: key);

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
            color:  const Color.fromARGB(255, 0, 10, 44), // DRAWER BG
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 18, 41, 104), // USER INFO PANEL
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(userImageUrl), 
                        ),
                      ),
                      const SizedBox(height: 5),
                      Center(
                        child: Text(
                          userName, 
                          style: const TextStyle(
                            color: const Color.fromARGB(255, 0, 255, 242),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          userEmail, 
                          style: const TextStyle(
                            color: const Color.fromARGB(255, 0, 255, 242),
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                ListTile(
                  leading: const Icon(Icons.account_circle, color: Colors.white, size: 40),
                  title: Text(
                    'P R O F I L E',
                    style: TextStyle(color: const Color.fromARGB(255, 0, 255, 242), fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    pageController.jumpToPage(3);
                  },
                ),
                Divider(color: const Color.fromARGB(255, 0, 10, 44)),
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.white, size: 40),
                  title: Text(
                    'A C C O U N T',
                    style: TextStyle(color: const Color.fromARGB(255, 0, 255, 242), fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  onTap: () {},
                ),
                Divider(color: const Color.fromARGB(255, 0, 10, 44)),
                ListTile(
                  leading: const Icon(Icons.build, color: Colors.white, size: 40),
                  title: Text(
                    'M Y  B U I L D S',
                    style: TextStyle(color: const Color.fromARGB(255, 0, 255, 242), fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    pageController.jumpToPage(1);
                  },
                ),
                Divider(color: const Color.fromARGB(255, 0, 10, 44)),
                ListTile(
                  leading: const Icon(Icons.question_mark_sharp, color: Colors.white, size: 40),
                  title: Text(
                    'H E L P',
                    style: TextStyle(color: const Color.fromARGB(255, 0, 255, 242), fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  onTap: () {},
                ),
                Divider(color: const Color.fromARGB(255, 0, 10, 44)),
                const SizedBox(height: 320),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.white, size: 40),
                  title: Text(
                    'L O G   O U T',
                    style: TextStyle(color: const Color.fromARGB(255, 0, 255, 242), fontWeight: FontWeight.bold, fontSize: 20),
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
