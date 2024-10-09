import 'package:flutter/material.dart';
import 'package:frontend/components/login_register_button.dart';
import 'package:frontend/components/login_textfield.dart';
import 'package:frontend/pages/login_page.dart';

class RegisterPage extends StatelessWidget {
 RegisterPage({ Key? key }) : super(key: key);

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // user register btn 
  void registerUser(BuildContext context){

    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  LoginPage()),
    );

  }

  void goToLogIn(BuildContext context){
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(

      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 100,),

            // logo
            Icon(Icons.circle,
            size: 200,
            ),

          Text('Sign Up',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
          ),

            // Username
            SizedBox(height: 20,),
            LoginTextfield(
              controller: usernameController, 
              hintText: 'Username', 
              obscureText: false),

            // Email
            SizedBox(height: 10,),
              LoginTextfield(
              controller: emailController, 
              hintText: 'Email', 
              obscureText: false),

            // Pass
            SizedBox(height: 10,),
              LoginTextfield(
              controller: passwordController, 
              hintText: 'Password', 
              obscureText: false),

            // Confirm Pass
            SizedBox(height: 10,),
              LoginTextfield(
              controller: null, 
              hintText: 'Confirm Password', 
              obscureText: false),

            // register btn
            SizedBox(height: 10,),
            LoginBtn(

              onPressed: () => registerUser(context),
              buttonText: 'Register',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16), 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10), 
                  TextButton(
                    onPressed: () {
                      goToLogIn(context);
                    },
                    child: Text(
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
        )
      ),
    );
  }
}