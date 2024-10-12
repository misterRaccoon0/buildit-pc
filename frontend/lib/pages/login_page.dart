import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; 
import 'package:frontend/components/login_register_button.dart';
import 'package:frontend/components/login_textfield.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/register_page.dart';
import 'package:frontend/services/auth_services.dart'; 

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService authService = AuthService(); 
  final storage = FlutterSecureStorage(); 
  bool isLoading = false; 

void signUserIn() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
        showError('Email and password cannot be empty.');
        return; 
    }

    setState(() {
        isLoading = true; 
    });

    String? token = await authService.loginUser(email, password); 

    setState(() {
        isLoading = false; 
    });

    if (token != null) {
        await storage.write(key: 'authToken', value: token); 

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false, 
        );
    } else {
        showError("Invalid Credentials"); 
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100),
              Icon(Icons.circle, size: 200),
              Text(
                'Sign In',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              SizedBox(height: 20),
              LoginTextfield(controller: emailController, hintText: 'Email', obscureText: false),
              SizedBox(height: 20),
              LoginTextfield(controller: passwordController, hintText: 'Password', obscureText: true),
              SizedBox(height: 20),
              isLoading 
                ? CircularProgressIndicator() 
                : LoginBtn(
                    onPressed: () {
                      if (!isLoading) {
                        signUserIn(); 
                      }
                    },
                    buttonText: isLoading ? 'Logging In...' : 'Log In',
                  ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterPage()),
                        );
                      },
                      child: Text(
                        'Sign up',
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
