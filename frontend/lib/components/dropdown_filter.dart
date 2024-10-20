import 'package:flutter/material.dart';

class DropdownFilter extends StatefulWidget {
  const DropdownFilter({Key? key}) : super(key: key);

  @override
  _DropdownFilterState createState() => _DropdownFilterState();
}

class _DropdownFilterState extends State<DropdownFilter> {
  String _dropdownValue = 'Popularity';

  void _showModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 4, 0, 255),
                const Color.fromARGB(255, 0, 140, 255),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.align_vertical_bottom_sharp, color: Colors.white), 
                title: Text('Popularity', style: TextStyle(color: Colors.white)),
                onTap: () {
                  _updateValue('Popularity', Icons.align_vertical_bottom_sharp);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.fiber_new, color: Colors.white), 
                title: Text('Latest', style: TextStyle(color: Colors.white)),
                onTap: () {
                  _updateValue('Latest', Icons.fiber_new);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.star, color: Colors.white), 
                title: Text('Highly Rated', style: TextStyle(color: Colors.white)),
                onTap: () {
                  _updateValue('Highly Rated', Icons.star);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateValue(String selectedValue, IconData selectedIcon) {
    setState(() {
      _dropdownValue = selectedValue;
      _selectedIcon = selectedIcon;
    });
  }

  IconData _selectedIcon = Icons.align_vertical_bottom_sharp; 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showModalBottomSheet,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10), 
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 4, 0, 255),
                const Color.fromARGB(255, 0, 140, 255),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: Colors.black,
              width: 0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(_selectedIcon, color: Colors.white), 
                  SizedBox(width: 10), 
                  Text(
                    _dropdownValue,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              Icon(Icons.arrow_drop_down, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
