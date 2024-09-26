import 'package:flutter/material.dart';
import 'package:frontend/components/component_selector.dart';

Widget ComponentCategory({
  required String title,
  required List<Component> components,
  required String initialValue,
  required Function(String?) onChanged,
}) {
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
          dropdownLabel: 'Select $title',
          components: components,
          initialValue: initialValue,
          onChanged: onChanged,
        ),
      ],
    ),
  );
}