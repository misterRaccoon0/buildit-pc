import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:frontend/minor%20pages/minor%20pages%20components/BenchMarkBar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Widget benchmarkBar(String label, int score1, int score2) {
  // Calculate the total range for scaling the bar width dynamically
  int maxScore = (score1 > score2 ? score1 : score2).clamp(1, 1000); // Prevent division by zero
  double barWidthFactor1 = score1 / maxScore;
  double barWidthFactor2 = score2 / maxScore;

  // Calculate the percentage difference between the two scores
  double percentageDifference = score1 > 0
      ? ((score2 - score1) / score1 * 100).abs()
      : 0.0;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // Centered label above the bars
      Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 8),

      // Bars and scores
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Build 1 score bar
          Expanded(
            flex: (barWidthFactor1 * 100).toInt(), // Adjust width dynamically
            child: Container(
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [Colors.blue.shade300, Colors.blue.shade900],
                ),
              ),
              child: Center(
                child: Text(
                  '$score1',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Build 2 score bar
          Expanded(
            flex: (barWidthFactor2 * 100).toInt(), // Adjust width dynamically
            child: Container(
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [Colors.green.shade300, Colors.green.shade900],
                ),
              ),
              child: Center(
                child: Text(
                  '$score2',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),

      // Display percentage difference
      Text(
        'Difference: ${percentageDifference.toStringAsFixed(1)}%',
        style: TextStyle(
          fontSize: 14,
          color: percentageDifference > 0 ? Colors.red : Colors.grey,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 16),
    ],
  );
}