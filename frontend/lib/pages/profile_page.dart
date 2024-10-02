import 'package:flutter/material.dart';
import 'package:frontend/minor%20screens/editProfile_screen.dart';
import 'package:frontend/minor%20screens/shared_listView.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
      title: Text( 'P R O F I L E',
      style: TextStyle(fontWeight: FontWeight.bold),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.grey[300],
    ),


      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage('https://via.placeholder.com/150'), // replace with user pic
                           ),
              ),           
        
              SizedBox(height: 30,),
        
              Center(
                child: const Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, 
                  ),
                ),
              ),
        
              const SizedBox(height: 10),
        
              // Email
              Center(
                child: const Text(
                  'john.doe@example.com',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey, 
                  ),
                ),
              ),
        
              const SizedBox(height: 20),
        
              // Edit btn
        
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfileScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[700], 
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), 
                    side: BorderSide(color: Colors.grey[400]!, width: 1), 
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24), 
                ),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white, 
                    fontWeight: FontWeight.bold
                  ), 
                ),
              ),
            ),

            SizedBox(height: 20,),

            Divider(color: Colors.grey[400]),

            const SizedBox(height: 20),

            // Shared Builds Section Title
            const Text(
              'S H A R E D   B U I L D S',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                ),
              ),

            SizedBox(height: 20,),

            SharedListView(itemCount: 5)
            ],
          ),
        ),
      ),
    );
  }
}
