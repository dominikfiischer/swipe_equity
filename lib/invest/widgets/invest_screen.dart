import 'package:flutter/material.dart';

class InvestScreen extends StatelessWidget {
  const InvestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investments'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white, // Sets the back button and title color
      ),
      backgroundColor: Colors.black,
      body: const Center(
        child: Text(
          'This is the Invest Screen.',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}