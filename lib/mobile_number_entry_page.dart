import 'package:flutter/material.dart';

class MobileNumberEntryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
       title: Text(
          "Enter Moible Number",
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
            TextField(
              decoration: InputDecoration(
                labelText: 'Mobile Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF0B4BA2), width: 2.0),
                ),
              ),
              keyboardType: TextInputType.phone,
              maxLength: 10,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement check and pay logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0B4BA2), // Button color

                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(fontSize: 20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check, color: Colors.white), // Right tick icon
                  SizedBox(width: 10),
                  Text('Check and Pay', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
