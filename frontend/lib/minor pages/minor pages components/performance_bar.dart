import 'package:flutter/material.dart';

class PerformanceBar extends StatelessWidget {
  final int totalScore;
  final String performanceLevel;

  PerformanceBar({required this.totalScore, required this.performanceLevel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              height: 20,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.orange, Colors.yellow, Colors.green],
                  stops: [0.0, 0.3, 0.6, 1.0],  
                ),
              ),
            ),

            Positioned(
              left: (MediaQuery.of(context).size.width - 32) * (totalScore / 120000).clamp(0.0, 1.0), 
              child: Container(
                width: 3,
                height: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ENTRY LEVEL', style: TextStyle(fontSize: 12, color:const Color.fromARGB(255, 1, 61, 110), fontWeight: FontWeight.bold)),
              Text('MID RANGE', style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 1, 61, 110),  fontWeight: FontWeight.bold)),
              Text('HIGH END', style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 1, 61, 110),  fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }
}

