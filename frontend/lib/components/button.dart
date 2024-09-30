import 'package:flutter/material.dart';

class LoginBtn extends StatelessWidget {

  final VoidCallback onPressed;
  final String buttonText;

  const LoginBtn({super.key, required this.onPressed, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(width: 365,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(25),
          backgroundColor: Colors.black, // Set the background color to black
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.white, // Text color
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}