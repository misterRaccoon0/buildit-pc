import 'package:flutter/material.dart';

class LoginBtn extends StatelessWidget {

  final VoidCallback onPressed;
  final String buttonText;

  const LoginBtn({super.key, required this.onPressed, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(width: 255,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding:const EdgeInsets.all(25),
          backgroundColor: Colors.black, 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), 
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white, 
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
