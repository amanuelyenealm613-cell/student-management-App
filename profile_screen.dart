import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('students')
          .doc(user!.uid)
          .get();
      if (doc.exists) {
        _nameController.text = doc.data()?['fullName'] ?? '';
      }
    }
    setState(() => _isLoading = false);
  }

  Future<void> _updateProfile() async {
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('students')
          .doc(user!.uid)
          .update({'fullName': _nameController.text.trim()});

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ፕሮፋይልዎ በ Firebase ተቀይሯል!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ፕሮፋይል መቀየሪያ')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.person, size: 50),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 18,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('የፕሮፋይል ፎቶ መምረጫ')),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Text('ኢሜይል: ${user?.email ?? ''}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'ስም ማሻሻያ',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateProfile,
              child: const Text('መረጃዎችን አስቀምጥ (Save)'),
            ),
          ],
        ),
      ),
    );
  }
}