import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final PageController pageController;

const AppDrawer({ Key? key, required this.pageController }) : super(key: key);


  @override
  Widget build(BuildContext context){

    return Drawer(
        child: Container(
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
                      backgroundImage: NetworkImage('https://via.placeholder.com/150'), // replace with user pic
                    ),

                    SizedBox(height: 5),
                    Text(
                      'John Doe', // replace with dynamic user name
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
     
                    Text(
                      'johndoe@example.com', // replace with dynamic email
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),

              // profile on drawer
              ListTile(
                leading: Icon(Icons.account_circle, 
                color: Colors.white,
                size: 40,
                ), 
                title: Text(
                  'P R O F I L E',
                  style: TextStyle(color: Colors.grey[100], 
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  ),
                ),
                onTap: () {
                  
                },
              ),

              Divider(color: Colors.grey[800]),

              // Account settings on draer
              ListTile(
                leading: Icon(Icons.settings, 
                color: Colors.white,
                size: 40,
                ), 
                title: Text(
                  'A C C O U N T',
                  style: TextStyle(color: Colors.grey[100],
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
                ),
                onTap: () {

                },
              ),


              Divider(color: Colors.grey[800]),

              // User builds on drawer
              ListTile(
                leading: Icon(Icons.build, color: Colors.white,
                size: 40,
                ),
                title: Text(
                  'M Y  B U I L D S',
                  style: TextStyle(color: Colors.grey[100],
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
                ),
                onTap: () {
                Navigator.pop(context); 
                  pageController.jumpToPage(1);
                },
              ),
            
              Divider(color: Colors.grey[800]),


              ListTile(
                leading: Icon(Icons.question_mark_sharp, color: Colors.white,
                size: 40,
                ),
                title: Text(
                  'H E L P',
                  style: TextStyle(color: Colors.grey[100],
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                  ),
                ),
                onTap: () {

                },
              ),


              Divider(color: Colors.grey[800]),

              SizedBox(height: 320,),
              // log out on drawer
              ListTile(
                leading: Icon(Icons.logout, color: Colors.white,
                size: 40,
                ),
                title: Text(
                  'L O G   O U T',
                  style: TextStyle(color: Colors.grey[100],
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
                ),
                onTap: () {
                  
                },
              ),
            ],
          ),
        ),
      );
  }
}