import 'package:flutter/material.dart';
import 'package:frontend/components/UserPost_Border.dart';
import 'package:frontend/components/app_drawer.dart';
import 'package:frontend/components/dropdown_filter.dart';
import 'package:frontend/components/bottom_navbar.dart';
import 'package:frontend/pages/build_page.dart';
import 'package:frontend/pages/create_page.dart';
import 'package:frontend/pages/profile_page.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final PageController pageController = PageController();
  int _currentIndex = 0; 

  @override
  void dispose() {
    pageController.dispose(); 
    super.dispose();
  }

  AppBar? _buildAppBar() {
  if (_currentIndex != 0) return null;
  return AppBar(
    title: ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          const Color.fromARGB(255, 4, 0, 255),
          const Color.fromARGB(255, 0, 140, 255),
          ],
        begin: Alignment.bottomLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(
        'B U I L D    I T',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white, 
        ),
      ),
    ),
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    actions: [

      IconButton(
        onPressed: () {

        }, 
        icon: Icon
        (Icons.notifications_none, 
        color: Colors.black
        )
      ),

      IconButton(
        onPressed: () {

        }, 
        icon: Icon(
          Icons.search, 
          color: Colors.black
          )
        ),

      IconButton(
        onPressed: () {
          _scaffoldKey.currentState?.openEndDrawer();
        },
        icon: Icon(
         Icons.menu,
          color: Colors.black,
          ),
        ),
    ],
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[350],

      appBar: _buildAppBar(),

      endDrawer: _currentIndex == 0 ? AppDrawer(pageController: pageController,) : null, 

      body: Column(
        children: [
          if (_currentIndex == 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                children: [
                  Expanded(child: DropdownFilter()),
                ],
              ),
            ),


          Expanded(
            
            child: PageView(
              
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index; 
                });
              },
              // Bottom nav bar pages
              children: [


                  ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                      child: UserPostBorder(),
                    );
                  },
                ),


                BuildPage(), 
                CreatePage(), 
                ProfilePage(),


              ],
            ),
          ),

          BottomNavbar(
            currentIndex: _currentIndex,
            onTap: (index) {
              pageController.jumpToPage(index); 
              setState(() {
                _currentIndex = index; 
              });
            },
          ),
        ],
      ),
    );
  }
}
