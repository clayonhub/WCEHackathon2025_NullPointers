import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // Import the file_picker package

class PanCardUpload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9), // Match the theme
      appBar: AppBar(
        title: Text('Upload PAN Card'),
        backgroundColor: Color(0xFF0B4BA2), // Match the theme
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0), // Match padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align to start
          children: [
            Text(
              "Step 3 of 3 - PAN Card Upload",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: 3 / 3, // Progress indicator for the third step
              backgroundColor: Colors.grey[300],
              color: Color(0xFF0B4BA2),
            ),
            SizedBox(height: 40),
            TextField(
              decoration: InputDecoration(
                labelText: "PAN Number",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Implement file picker logic
                final result = await FilePicker.platform.pickFiles();
                if (result != null) {
                  // Handle file selection
                }
              },
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              side: BorderSide(color: Color(0xFF0B4BA2), width: 2),
            ),
            child: Text(
              "Upload Pan Card (PDF/Image)",
              style: TextStyle(fontSize: 18, color: Color(0xFF0B4BA2)),
              
            ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Navigate to Bank Account Details page
                Navigator.pushNamed(context, '/bankAccountDetails');
              },
              child: Text(
                'NEXT',
                style: TextStyle(fontSize: 18, color: Colors.white), // Set text color to white
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0B4BA2), // Match the theme
                 padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20), // Adjust button size
              ),
            ),
          ],
        ),
      ),
    );
  }
}