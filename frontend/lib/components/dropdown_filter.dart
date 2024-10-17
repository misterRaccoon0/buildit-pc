import 'package:flutter/material.dart';

class DropdownFilter extends StatefulWidget {
  const DropdownFilter({ Key? key }) : super(key: key);

  @override
  _DropdownFilterState createState() => _DropdownFilterState();
}

class _DropdownFilterState extends State<DropdownFilter> {
  String _dropdownValue = 'Popularity';

  void dropdownCallBack(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 0, 255, 242),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white, 
            width: 1,
          ),
        ),


        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _dropdownValue,
            borderRadius: BorderRadius.circular(10),
            icon: Icon(Icons.arrow_drop_down, color: Colors.black),
            items: [
              DropdownMenuItem(
                child: Text('Popularity'),
                value: 'Popularity',
              ),
              DropdownMenuItem(
                child: Text('Latest'),
                value: 'Latest',
              ),
              DropdownMenuItem(
                child: Text('Highly Rated'),
                value: 'Highly Rated',
              ),
            ],
            onChanged: dropdownCallBack,
          ),
        ),
      ),
    );
  }
}
