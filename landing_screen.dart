import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('እንኳን ወደ ትምህርት ቤታችን በደህና መጡ'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: const Text('Log In', style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.school, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              'ታላቁ የልህቀት ትምህርት ቤት',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            const Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'ትምህርት ቤታችን ጥራት ያለው ትምህርት፣ ዘመናዊ የቴክኖሎጂ ላብራቶሪዎች እና ብቁ መምህራን ያሉት የተማሪዎች ሁለንተናዊ እድገት ማዕከል ነው።',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'የትምህርት ቤቱ ደንቦች፡',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            const ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('የሰዓት አከባበር እና የትምህርት ቤት ዩኒፎርም ማክበር።'),
            ),
            const ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('የሳይንስ እና ቴክኖሎጂ ላቦራቶሪዎችን በጥንቃቄ መጠቀም።'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 15),
                backgroundColor: Colors.blueAccent,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegistrationScreen()),
                );
              },
              child: const Text(
                'ለመመዝገብ ይህንን ይሙሉ',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}