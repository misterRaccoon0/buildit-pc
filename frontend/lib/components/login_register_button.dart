import 'package:flutter/material.dart';

class LoginBtn extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const LoginBtn({
    Key? key,
    required this.onPressed,
    required this.buttonText,
  }) : super(key: key);

@override
Widget build(BuildContext context) {
  return SizedBox(
    width: 365,

    
    child: Stack(
      children: [

        Positioned.fill(
          child: ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: [
                  const Color.fromARGB(255, 0, 17, 255),
                  const Color.fromARGB(255, 0, 140, 255),
                  const Color.fromARGB(255, 0, 217, 255),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop, 
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),

        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(25),
            backgroundColor: Colors.transparent, 
            shadowColor: Colors.transparent, 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Center(
            child: Transform.scale(
              scale: 1.5,
              child: Text(
                buttonText,
                style: TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

}