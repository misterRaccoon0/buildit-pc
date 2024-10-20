import 'package:flutter/material.dart';
import 'package:frontend/components/login_register_button.dart';
import 'package:frontend/components/login_textfield.dart';
import 'package:frontend/pages/LoginPage.dart';
import 'package:frontend/services/auth_services.dart'; 

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final AuthService authService = AuthService(); 

  void registerUser() async {
    String name = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (password != confirmPassword) {
      showError('Passwords do not match');
      return;
    }

    String response = await authService.registerUser(name, email, password);

    if (response == 'OK') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      showError(response);
    }
  }

  void showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void goToLogIn() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),
              const Icon(Icons.circle, size: 200),
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              const SizedBox(height: 20),
              LoginTextfield(controller: usernameController, hintText: 'Username', obscureText: false),
              const SizedBox(height: 10),
              LoginTextfield(controller: emailController, hintText: 'Email', obscureText: false),
              const SizedBox(height: 10),
              LoginTextfield(controller: passwordController, hintText: 'Password', obscureText: true),
              const SizedBox(height: 10),
              LoginTextfield(controller: confirmPasswordController, hintText: 'Confirm Password', obscureText: true),
              const SizedBox(height: 10),
              LoginBtn(onPressed: registerUser, buttonText: 'Register'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: goToLogIn,
                      child:const Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
