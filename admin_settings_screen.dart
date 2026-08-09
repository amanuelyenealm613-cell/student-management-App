import 'package:flutter/material.dart';

class AdminSettingsScreen extends StatefulWidget {
  const AdminSettingsScreen({super.key});

  @override
  State<AdminSettingsScreen> createState() => _AdminSettingsScreenState();
}

class _AdminSettingsScreenState extends State<AdminSettingsScreen> {
  final _rulesController = TextEditingController(
    text: "1. የሰዓት አከባበር ማክበር\n2. የትምህርት ቤት ዩኒፎርም መልበስ\n3. የላቦራቶሪ እቃዎችን በጥንቃቄ መጠቀም",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('የትምህርት ቤት ቅንብሮች (Admin)')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('የትምህርት ቤት ሎጎ ቀይር፡', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ሎጎ መምረጫ ተከፍቷል')),
                );
              },
              icon: const Icon(Icons.image),
              label: const Text('አዲስ ሎጎ ይምረጡ'),
            ),
            const SizedBox(height: 20),
            const Text('የትምህርት ቤት ደንቦች ማሻሻያ፡', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              controller: _rulesController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('የትምህርት ቤቱ ደንቦች እና ሎጎ ተቀይረዋል!')),
                );
              },
              child: const Text('ለዉጦችን መዝግብ', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}