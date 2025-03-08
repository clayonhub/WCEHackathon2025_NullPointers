import 'package:flutter/material.dart';

class BankAccountDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9), // Match the theme
      appBar: AppBar(
        title: Text(
          "Bank Account Details",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xFF0B4BA2),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0), // Match padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Account Holder Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: "Account Number",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: "Confirm Account Number",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Account Type",
                border: OutlineInputBorder(),
              ),
              items: <String>['Savings', 'Current', 'Fixed Deposit']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Handle account type selection
              },
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: "IFSC Code",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement the logic to proceed to the next step
                Navigator.pushNamed(context, '/kycCompleted');
              },
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 18, color: Colors.white), // Set text color to white
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0B4BA2), // Match the theme
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Adjust button size
              ),
            ),
          ],
        ),
      ),
    );
  }
}