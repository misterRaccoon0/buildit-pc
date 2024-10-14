import 'package:flutter/material.dart';
import 'package:frontend/components/component_selector.dart';

class ComponentCategory extends StatelessWidget {
  final String title;
  final List<Component> components;
  final Function(String?) onChanged;
  final GlobalKey<ComponentSelectorState>? componentSelectorKey;

  const ComponentCategory({
    Key? key,
    required this.title,
    required this.components,
    required this.onChanged,
    this.componentSelectorKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          ComponentSelector(
            key: componentSelectorKey,
            dropdownLabel: title,
            components: components,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

