import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elderly-Focused Fraud Detection App'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Implement menu action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Status Bar
          Container(
            color: Colors.green,
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.lock, color: Colors.white),
                SizedBox(width: 10),
                Text('Current Status: Safe', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          SizedBox(height: 10),

          // Primary Functionality Icons
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                _buildFunctionalityButton(context, Icons.credit_card, 'Make Payment', () {
                  // Navigate to payment functionality
                }),
                _buildFunctionalityButton(context, Icons.account_balance, 'Check Balance', () {
                  // Navigate to check balance functionality
                }),
                _buildFunctionalityButton(context, Icons.abc, 'Nominee Setup', () {
                  // Navigate to nominee setup
                }),
                _buildFunctionalityButton(context, Icons.security, 'Stay Secure', () {
                  // Navigate to security tips
                }),
                _buildFunctionalityButton(context, Icons.warning, 'Scams', () {
                  // Navigate to scams information
                }),
                _buildFunctionalityButton(context, Icons.help, 'Help Desk', () {
                  // Navigate to help desk
                }),
              ],
            ),
          ),

          // Alerts Section
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.yellow,
            child: Text('Alerts: Please verify your KYC.', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
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
                // Navigate to home
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

  Widget _buildFunctionalityButton(BuildContext context, IconData icon, String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50),
            SizedBox(height: 10),
            Text(label, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
