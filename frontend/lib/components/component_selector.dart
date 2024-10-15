import 'package:flutter/material.dart';

class Component {
  final int id;
  final String name;
  final String specs;
  final int price;
  final int tdp;
  final String imageUrl;
  final String socket;
  final String gen; // for ram
  final String ramsupport; // for motherboard
  final int benchmark;

  Component({
    required this.id,
    required this.name,
    required this.specs,
    required this.price,
    required this.tdp,
    required this.imageUrl,
    required this.socket,
    required this.gen, // for ram
    required this.ramsupport,
    required this.benchmark
  });
}

class ComponentSelector extends StatefulWidget {
  final List<Component> components;
  final String dropdownLabel;
  final Function(String?) onChanged;

  const ComponentSelector({
    Key? key,
    required this.components,
    required this.dropdownLabel,
    required this.onChanged,
  }) : super(key: key);

  @override
  ComponentSelectorState createState() => ComponentSelectorState();
}

class ComponentSelectorState extends State<ComponentSelector> {
  late String _selectedValue;
  late TextEditingController _searchController;
  late List<Component> _filteredComponents;
  Component? _selectedComponent;

  @override
  void initState() {
    super.initState();
    _selectedValue = 'Select ${widget.dropdownLabel}';
    _searchController = TextEditingController();
    _filteredComponents = widget.components;

    _searchController.addListener(_filterComponents);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterComponents() {
    setState(() {
      _filteredComponents = widget.components
          .where((component) =>
              component.name.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  void resetComponentView() {
    print("Resetting component: ${widget.dropdownLabel}");
    setState(() {
      _selectedValue = 'Select ${widget.dropdownLabel}';
      
      _selectedComponent = null;  
      _searchController.clear();  
      _filteredComponents = widget.components;  

      widget.onChanged(null);  
    });
  }


  void _showComponentDropdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search Component',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              if (_selectedComponent != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          _selectedComponent!.imageUrl,
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '${_selectedComponent!.name}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '${_selectedComponent!.specs}',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredComponents.length,
                  itemBuilder: (context, index) {
                    final component = _filteredComponents[index];
                    return ListTile(
                      leading: component.imageUrl.isNotEmpty
                          ? Image.network(
                              component.imageUrl,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              height: 50,
                              width: 50,
                              color: Colors.grey[300],
                              child: Icon(Icons.image, size: 24),
                            ),
                      title: Text(component.name),
                      subtitle: Text(component.specs),
                      trailing: Text('₱${component.price}'),
                      onTap: () {
                        setState(() {
                          _selectedComponent = component;
                          _selectedValue = component.name;
                          widget.onChanged(component.name);
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showComponentDropdown(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            if (_selectedComponent != null)
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      _selectedComponent!.imageUrl,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    _selectedValue,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              )
            else
              Text(
                _selectedValue == 'Select ${widget.dropdownLabel}'
                    ? 'Select ${widget.dropdownLabel}'
                    : _selectedValue,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            const Spacer(),
            const Icon(Icons.arrow_drop_down),
            
          ],
        ),
      ),
    );
  }
}
