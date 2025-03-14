import 'package:flutter/material.dart';
import 'mobile_number_entry_page.dart'; // Import the MobileNumberEntryPage

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text(
          "Make Payment",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xFF0B4BA2),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPaymentButton(context, Icons.phone, 'Enter Phone Number', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MobileNumberEntryPage()), // Navigate to MobileNumberEntryPage
              );
            }),
            SizedBox(height: 20),
            _buildPaymentButton(context, Icons.qr_code, 'Scan QR Code', () {
              // Implement QR code scanning logic
            }),
            SizedBox(height: 20),
            _buildPaymentButton(context, Icons.account_balance, 'Enter UPI ID', () {
              // Implement UPI ID entry logic
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentButton(BuildContext context, IconData icon, String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF0B4BA2),
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        textStyle: TextStyle(fontSize: 20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30,color: Colors.white),
          SizedBox(width: 10),
                  Text(label, style: TextStyle(color: Colors.white)), 

        ],
      ),
    );
  }
}
