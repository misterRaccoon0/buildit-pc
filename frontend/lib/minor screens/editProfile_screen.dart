import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  var _name = 'John Doe';
  var _email = 'john.doe@example.com';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Edit Profile'),
      actions: [
        IconButton(
          icon: const Icon(Icons.save),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _buildNameField(),
            _buildEmailField(),
            const SizedBox(height: 20),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  TextFormField _buildNameField() {
    return TextFormField(
      initialValue: _name,
      decoration: const InputDecoration(labelText: 'Name'),
      style: const TextStyle(),
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
      decoration: const InputDecoration(labelText: 'Email'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }

        return null;
      },
      onSaved: (value) {
        _email = value!;
      },
    );
  }

  ElevatedButton _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          Navigator.pop(context);
        }
      },
      child: const Text('Save Changes'),
    );
  }
}