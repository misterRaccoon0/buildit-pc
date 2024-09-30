import 'package:flutter/material.dart';
import 'package:frontend/components/button.dart';
import 'package:frontend/components/login_textfield.dart';
import 'package:frontend/pages/register_page.dart';
import 'package:frontend/pages/home_page.dart';



class LoginPage extends StatelessWidget {
  LoginPage({ Key? key }) : super(key: key);

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // user sign in btn method
  void signUserIn (BuildContext context) {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  HomePage()),
    );
  }

  void goToRegister(BuildContext context){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(child: Column(
        children: [
          SizedBox(height: 100),

          //logo
          Icon(
            Icons.circle,
            size: 200,
          ),

          Text('Sign In',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,

          )
          ),

          SizedBox(height: 20,),

          // Username email
          LoginTextfield(
            controller: usernameController,
            hintText: 'Username',
            obscureText: false,
          ),

          SizedBox(height: 30,),

          // pass
          LoginTextfield(
            controller: passwordController,
            hintText: 'Password',
            obscureText: true,
          ),

          // btn 
          SizedBox(height: 30,),
          LoginBtn(
            
            onPressed: () => signUserIn(context), 
            
            buttonText: 'Log In',
          ),

          // sign up prompt
          SizedBox(height: 20),

          // go to register screen
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),


                SizedBox(width: 55),
                TextButton(
                  onPressed: () {
                    goToRegister(context);
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
          



        ],
      )),
    );
  }
}