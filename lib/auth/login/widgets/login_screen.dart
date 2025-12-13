import 'package:flutter/material.dart';
// Import your main content screen for navigation
import '../../../home/widgets/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // Helper method to handle navigation
  void _navigateToHomeScreen(BuildContext context) {
    // Navigating to the HomeScreen and replacing the current route
    // so the user cannot press back to the login screen.
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // We use SafeArea to ensure content isn't under the notch/status bar.
    return Scaffold(
      backgroundColor: const Color(000), // black background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // 1. Title Section (Centered and pushed to the top)
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Swipe Equity',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tinder. But for Assets.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Button Section (Aligned to the bottom)
              Column(
                children: [
                  // Create Account Button (White/Light Grey)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _navigateToHomeScreen(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Log in Button (Dark Grey)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _navigateToHomeScreen(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF555555), // Slightly lighter dark gray
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}