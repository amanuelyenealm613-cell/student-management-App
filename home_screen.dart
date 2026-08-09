import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_screen.dart';
import 'admin_settings_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _addStudent(String name) async {
    await FirebaseFirestore.instance.collection('students').add({
      'fullName': name,
      'registrationCode': '2116',
      'email': 'student_${DateTime
          .now()
          .millisecondsSinceEpoch}@school.com',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  void _removeStudent(String docId) async {
    await FirebaseFirestore.instance.collection('students').doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ዋናው የትምህርት ቤት ገጽ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            tooltip: 'የትምህርት ቤት ቅንብር',
            onPressed: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const AdminSettingsScreen()),
                ),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'ፕሮፋይል',
            onPressed: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'ውጣ',
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'የተማሪዎች ዝርዝር (Firebase Realtime)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('students')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('ምንም የተመዘገበ ተማሪ የለም'));
                }

                final docs = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;
                    final docId = docs[index].id;

                    return ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(data['fullName'] ?? 'ስም የለውም'),
                      subtitle: Text('ኢሜይል: ${data['email'] ?? ''}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeStudent(docId),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TextEditingController nameController = TextEditingController();
          showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: const Text('አዲስ ተማሪ ጨምር'),
                  content: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(hintText: "የተማሪ ስም"),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('ሰርዝ'),
                    ),
                    TextButton(
                      onPressed: () {
                        if (nameController.text.isNotEmpty) {
                          _addStudent(nameController.text);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('ጨምር'),
                    ),
                  ],
                ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}