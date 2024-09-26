import 'package:flutter/material.dart';
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
    title: Text(
      'B U I L D    I T',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    automaticallyImplyLeading: false,
    backgroundColor: Colors.grey[300],
    actions: [
      IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
      IconButton(onPressed: () {}, icon: Icon(Icons.search)),
    ],
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[300],

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
                  IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState?.openEndDrawer();
                    },
                    icon: Icon(
                      Icons.menu,
                      size: 50,
                    ),
                  ),
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
                Center(child: Text("Home Page Content Here")), 
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
