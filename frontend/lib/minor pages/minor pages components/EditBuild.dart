import 'dart:io'; // Import this for File handling
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditBuildPage extends StatefulWidget {
  final int buildID;
  final String buildName;
  final String? buildDescription;
  final String buildPic; 
  final Function(int, String?, String?, String?) onEdit; 

  const EditBuildPage({
    super.key,
    required this.buildID,
    required this.buildName,
    this.buildDescription,
    required this.buildPic,
    required this.onEdit,
  });

  @override
  _EditBuildPageState createState() => _EditBuildPageState();
}

class _EditBuildPageState extends State<EditBuildPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? selectedImagePath; 

  @override
  void initState() {
    super.initState();
    
    nameController.text = widget.buildName;
    descriptionController.text = widget.buildDescription ?? '';
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImagePath = image.path; // Save the path of the selected image
      });
    }
  }

  void _saveChanges() {
    widget.onEdit(widget.buildID, nameController.text, descriptionController.text, selectedImagePath);
    Navigator.of(context).pop(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Build'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Build Name'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16),
            // Display selected image or default image
            selectedImagePath != null
                ? Image.file(File(selectedImagePath!), height: 100) 
                : Image.network(widget.buildPic, height: 100), 
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Upload Image'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveChanges,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
