import 'package:flutter/material.dart';

class TinderCard extends StatelessWidget {
  final Color color;

  const TinderCard({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}