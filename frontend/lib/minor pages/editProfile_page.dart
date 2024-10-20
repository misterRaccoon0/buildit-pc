import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:frontend/services/ImageUpload_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:frontend/services/user_profile.dart'; 

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  File? _imageFile;
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();
  final ImageUploadService _uploadService = ImageUploadService();
  
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final userProfile = await fetchUserProfile();
      setState(() {
        _name = userProfile['name']; 
        _email = userProfile['email']; 
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching profile: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _isLoading ? _buildLoading() : _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Edit Profile'),
      actions: [
        IconButton(
          icon: const Icon(Icons.save),
          onPressed: _saveProfile,  
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Edit Your Profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildNameField(),
              const SizedBox(height: 20),
              _buildEmailField(),
              const SizedBox(height: 20),
              _buildImagePicker(),
              const SizedBox(height: 20),
              Center(child: _buildSaveButton()),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildNameField() {
    return TextFormField(
      initialValue: _name,
      decoration: const InputDecoration(
        labelText: 'Name',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
      onSaved: (value) {
        _name = value!;
      },
    );
  }

  TextFormField _buildEmailField() {
    return TextFormField(
      initialValue: _email,
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
      onSaved: (value) {
        _email = value!;
      },
    );
  }

  Widget _buildImagePicker() {
    return Center(
      child: Column(
        children: [
          _imageFile == null
              ? const Text('No image selected', style: TextStyle(color: Colors.grey))
              : ClipOval(
                  child: Image.file(
                    _imageFile!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _pickImage,
            style: ElevatedButton.styleFrom(
              iconColor: Colors.blue[800],
            ),
            child: const Text('Select Profile Image'),
          ),
        ],
      ),
    );
  }

  ElevatedButton _buildSaveButton() {
    return ElevatedButton(
      onPressed: _saveProfile,
      style: ElevatedButton.styleFrom(
        iconColor: Colors.green,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
      ),
      child: const Text(
        'Save Changes',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _isLoading = true;
      });

      try {
        String? imageUrl;
        if (_imageFile != null) {
          imageUrl = await _uploadService.uploadImage(_imageFile!);
        }

        await updateProfile(
          name: _name,
          email: _email,
          imagePath: imageUrl, 
        );

       
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );

        Navigator.pop(context);
      } catch (error) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $error')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
