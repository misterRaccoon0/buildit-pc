import 'package:flutter/material.dart';
import 'package:frontend/components/login_register_button.dart';
import 'package:frontend/components/login_textfield.dart';
import 'package:frontend/pages/login_page.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100),
              Icon(Icons.circle, size: 200),
              Text(
                'Sign Up',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              LoginTextfield(controller: usernameController, hintText: 'Username', obscureText: false),
              SizedBox(height: 10),
              LoginTextfield(controller: emailController, hintText: 'Email', obscureText: false),
              SizedBox(height: 10),
              LoginTextfield(controller: passwordController, hintText: 'Password', obscureText: true),
              SizedBox(height: 10),
              LoginTextfield(controller: confirmPasswordController, hintText: 'Confirm Password', obscureText: true),
              SizedBox(height: 10),
              LoginBtn(onPressed: registerUser, buttonText: 'Register'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 18,
                        //fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      onPressed: goToLogIn,
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 183, 255),
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
