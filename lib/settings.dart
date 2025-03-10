import 'package:flutter/material.dart';
import 'main.dart'; // Import main.dart for HomeScreen

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color(0xFF0B4BA2),
      ),
      body: Column(
        children: [
          _buildButton(context, Icons.person, 'Change Nominee', () {
            // Navigate to Change Nominee page
          }),
          _buildButton(context, Icons.security, 'Security', () {
            // Navigate to Security page
          }),
          _buildButton(context, Icons.notifications, 'Notifications', () {
            // Navigate to Notifications page
          }),
          _buildButton(context, Icons.language, 'Change Language', () {
            // Navigate to Change Language page
          }),
          _buildButton(context, Icons.exit_to_app, 'Log Out', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()), // Navigate to HomeScreen
            );
          }, isLogout: true),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.message, color: Colors.white),
              onPressed: () {
                // Navigate to messages
              },
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white),
              onPressed: () {
                // Implement logout functionality
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, IconData icon, String label, VoidCallback onPressed, {bool isLogout = false}) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: isLogout ? Colors.red : Colors.white, // Red for logout button
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(icon, size: 30),
              SizedBox(width: 10),
              Text(label, style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
