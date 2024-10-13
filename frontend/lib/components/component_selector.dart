import 'package:flutter/material.dart';

// TEST LANG
class Component {
  final String name;
  final String specs;
  final int price;
  final int? tdp;
  final String imageUrl;

  Component({
    required this.name,
    required this.specs,
    required this.price,
    this.tdp,
    required this.imageUrl,
  });
}

class ComponentSelector extends StatefulWidget {
  final List<Component> components;
  final String dropdownLabel;
  final Function(String?) onChanged;
  final String initialValue;

  const ComponentSelector({
    Key? key,
    required this.components,
    required this.dropdownLabel,
    required this.onChanged,
    required this.initialValue,
  }) : super(key: key);

  @override
  _ComponentSelectorState createState() => _ComponentSelectorState();
}

class _ComponentSelectorState extends State<ComponentSelector> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              menuMaxHeight: 400,
              value: _selectedValue.isNotEmpty ? _selectedValue : null, 
              hint: Text(widget.dropdownLabel), 
              items: [
                DropdownMenuItem<String>(
                  value: '',
                  child: Text(widget.dropdownLabel), 
                ),
                ...widget.components.map((component) {
                  return DropdownMenuItem<String>(
                    value: component.name,
                    child: Row(
                      children: [
                        Image.network(
                          component.imageUrl,
                          width: 50,
                          height: 50,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.broken_image, size: 50); 
                          },
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              component.name,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              component.specs, 
                              style: TextStyle(fontSize: 12, color: Colors.grey[900]),
                            ),
                            
                          ],
                        ),
                        const Spacer(),
                        if (component.price > 0)
                          Text(
                            '₱${component.price}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[900],
                            ),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedValue = value ?? ''; 
                });
                widget.onChanged(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}
