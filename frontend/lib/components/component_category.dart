import 'package:flutter/material.dart';
import 'package:frontend/components/component_selector.dart';

class ComponentCategory extends StatefulWidget {
  final String title;
  final List<Component> components;
  final Function(String?) onChanged;
  final GlobalKey<ComponentSelectorState>? componentKey;

  const ComponentCategory({
    super.key,
    required this.title,
    required this.components,
    required this.onChanged,
    this.componentKey,
  });

  @override
  State<ComponentCategory> createState() => _ComponentCategoryState();
}

class _ComponentCategoryState extends State<ComponentCategory> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle( fontSize: 20, color: Colors.blue[900]),
          ),
          ComponentSelector(
            key: widget.componentKey,
            dropdownLabel: widget.title,
            components: widget.components,
            onChanged: widget.onChanged,
          ),
        ],
      ),
    );
  }
}

