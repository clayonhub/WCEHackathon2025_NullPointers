import 'package:flutter/material.dart';

class KYCCompleted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9), // Match the theme
      appBar: AppBar(
        title: Text('KYC Completed'),
        backgroundColor: Color(0xFF0B4BA2), // Match the theme
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100, // Right tick icon
            ),
            SizedBox(height: 20),
            Text(
              'Thanks for submitting your document. We\'ll verify it and complete your KYC as soon as possible.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement the logic to continue
                Navigator.pushNamed(context, '/nextPage'); // Replace with the actual next page
              },
              child: Text(
                'ALL SET! CONTINUE',
                style: TextStyle(fontSize: 18, color: Colors.white), // Set text color to white
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0B4BA2), // Match the theme
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20), // Increase button size
              ),
            ),
          ],
        ),
      ),
    );
  }
}
