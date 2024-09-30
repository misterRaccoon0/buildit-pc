import 'package:flutter/material.dart';
import 'package:frontend/components/dropdown_filter.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[300],

      // app bar elements 
      appBar: AppBar(
        title: Text('BuildIt PC',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[300],
        
        actions: [

          IconButton(
            onPressed: (){},
            icon: Icon(Icons.notifications)),

          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.search))
        ],
      ),

      endDrawer: Drawer(
        child: ListView(
          children: [

            ListTile(
              title: Text('Settings'),
              onTap: (){}
            ),

            ListTile(
              title: Text('My Builds'),
              onTap: (){}
            ),

            ListTile(
              title: Text('Log out'),
              onTap: (){}
            ),

          ],
        ),
      ),

    body: Row(
      children: [

          DropdownFilter(),

          Padding(
            padding: const EdgeInsets.only(left:185),
            child: Builder(
              builder: (context) {
                return IconButton(
                  onPressed: (){
                    _scaffoldKey.currentState?.openEndDrawer();                  
                  },
                  icon: Icon(Icons.account_circle_sharp,
                  size: 50,),
                  );
              }
            ),
          ),

          

        

      

    ],),      
      

      

      
      

    );
  }
}