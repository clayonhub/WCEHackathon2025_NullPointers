import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SAHAYAK",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xFF0B4BA2),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
  Scaffold.of(context).openDrawer();
},

          ),
        ],
      ),
      drawer: Drawer(
  backgroundColor: Color(0xFF0B4BA2), // Same color as AppBar
  child: ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        child: Text(
          'Menu',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        decoration: BoxDecoration(
          color: Color(0xFF0B4BA2),
        ),
      ),
      ListTile(
        leading: Icon(Icons.person, color: Colors.white),
        title: Text('Profile', style: TextStyle(color: Colors.white)),
        onTap: () {
          // Handle Profile action
          Navigator.pop(context); // Close the drawer
        },
      ),
      ListTile(
        leading: Icon(Icons.color_lens, color: Colors.white),
        title: Text('Theme', style: TextStyle(color: Colors.white)),
        onTap: () {
          // Handle Theme action
          Navigator.pop(context); // Close the drawer
        },
      ),
      ListTile(
        leading: Icon(Icons.settings, color: Colors.white),
        title: Text('Settings', style: TextStyle(color: Colors.white)),
        onTap: () {
          // Handle Settings action
          Navigator.pop(context); // Close the drawer
        },
      ),
    ],
  ),
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
                _buildFunctionalityButton(context, Icons.people, 'Nominee Setup', () {
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
