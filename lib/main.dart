import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // Import the file_picker package
import 'pan_card_upload.dart'; // Import the PAN card upload page
import 'bank_account_details.dart'; // Import the bank account details page
import 'kyc_completed.dart'; // Import the KYC completed page
import 'homepage.dart'; // Import the HomePage
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      routes: {
        '/panCardUpload': (context) => PanCardUpload(),
        '/bankAccountDetails': (context) => BankAccountDetails(),
        '/kycCompleted': (context) => KYCCompleted(),
        '/homepage': (context) => HomeScreen(), // Added route for homepage

      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/safepay.png',
              height: 300,
              width: 300,
            ),
            SizedBox(height: 20),

            DropdownButton<String>(
              value: selectedLanguage,
              items: ['English', 'Marathi', 'Hindi']
                  .map((lang) => DropdownMenuItem(
                        value: lang,
                        child: Text(lang, style: TextStyle(fontSize: 20)),
                      ))
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedLanguage = newValue!;
                });
              },
            ),
            SizedBox(height: 70),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()), // Navigate to LoginPage
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0B4BA2),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: Text(
                '       Log In       ',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0B4BA2),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: Text(
                'Create Account',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// Login Page
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String selectedRole = 'Account Holder';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9),
      appBar: AppBar(
        title: Text(
          "Login As",
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
            // Slider for Account Holder and Nominee
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRole = 'Account Holder';
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: selectedRole == 'Account Holder' ? Color(0xFF0B4BA2) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xFF0B4BA2)),
                    ),
                    child: Text(
                      'Account Holder',
                      style: TextStyle(
                        color: selectedRole == 'Account Holder' ? Colors.white : Color(0xFF0B4BA2),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRole = 'Nominee';
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: selectedRole == 'Nominee' ? Color(0xFF0B4BA2) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xFF0B4BA2)),
                    ),
                    child: Text(
                      'Nominee',
                      style: TextStyle(
                        color: selectedRole == 'Nominee' ? Colors.white : Color(0xFF0B4BA2),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),

            // Email and Password Fields
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: selectedRole == 'Account Holder' ? "Account Holder Email" : "Nominee Email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 40),

            // Login Button
            ElevatedButton(
              onPressed: () {
                if(selectedRole == 'Account Holder'){
                // Navigate to HomePage
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()), // Update to direct to HomePage
                );
                }
                else(){
                  // Navigate to NomineePage
                };
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0B4BA2),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              ),
              child: Text(
                "LOG IN",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Register Page
class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9),
      appBar: AppBar(
        title: Text(
          "Register",
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
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                labelText: "E-mail",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                labelText: "Phone",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                labelText: "Confirm Password",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AadharFrontPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0B4BA2),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              ),
              child: Text(
                "PROCEED TO KYC VERIFICATION",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Aadhar Front Upload Page
class AadharFrontPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9),
      appBar: AppBar(
        title: Text(
          "Aadhar Front",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xFF0B4BA2),
        centerTitle: true,
      ),
      body: DocumentUploadScreen(
        title: "Aadhar Front",
        step: 1,
        onNext: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AadharBackPage()),
          );
        },
      ),
    );
  }
}

// Aadhar Back Upload Page
class AadharBackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9),
      appBar: AppBar(
        title: Text(
          "Aadhar Back",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color(0xFF0B4BA2),
        centerTitle: true,
      ),
      body: DocumentUploadScreen(
        title: "Aadhar Back",
        step: 2,
        onNext: () {
          // Navigate to PAN card upload page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PanCardUpload()),
          );
        },
      ),
    );
  }
}

// Reusable Document Upload Screen
class DocumentUploadScreen extends StatefulWidget {
  final String title;
  final int step;
  final VoidCallback onNext;

  DocumentUploadScreen({required this.title, required this.step, required this.onNext});

  @override
  _DocumentUploadScreenState createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  final TextEditingController aadharController = TextEditingController();
  String? selectedFile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Step ${widget.step} of 3 - ${widget.title} Upload",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 10),
          LinearProgressIndicator(
            value: widget.step / 3,
            backgroundColor: Colors.grey[300],
            color: Color(0xFF0B4BA2),
          ),
          SizedBox(height: 40),

          // Aadhar Number Input
          TextField(
            controller: aadharController,
            decoration: InputDecoration(
              labelText: "Aadhar Number",
              border: OutlineInputBorder(),
              errorText: aadharController.text.length != 12 && aadharController.text.isNotEmpty
                  ? "Please enter a valid 12-digit Aadhar number."
                  : null,
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20),

          // File Upload Button
          ElevatedButton(
            onPressed: () async {
              // Implement file picker logic
              final result = await FilePicker.platform.pickFiles();
              if (result != null) {
                setState(() {
                  selectedFile = result.files.single.name;
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              side: BorderSide(color: Color(0xFF0B4BA2), width: 2),
            ),
            child: Text(
              "Upload ${widget.title} (PDF/Image)",
              style: TextStyle(fontSize: 18, color: Color(0xFF0B4BA2)),
            ),
          ),
          if (selectedFile != null) ...[
            SizedBox(height: 10),
            Text("Selected File: $selectedFile", style: TextStyle(color: Colors.green)),
          ],
          SizedBox(height: 40),

          // Next Button
          ElevatedButton(
            onPressed: () {
              // Validate Aadhar number
              if (aadharController.text.length != 12) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Please enter a valid 12-digit Aadhar number.")),
                );
              } else {
                widget.onNext();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF0B4BA2),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            ),
            child: Text(
              "NEXT",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
