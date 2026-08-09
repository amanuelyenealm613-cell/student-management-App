import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/custom_text_field.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _regCodeController = TextEditingController(text: '2116');
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _certificateUploaded = false;

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_certificateUploaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('እባክዎን የስርተፊኬት/የውጤት ፎቶ ያያይዙ')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await FirebaseFirestore.instance
          .collection('students')
          .doc(userCredential.user!.uid)
          .set({
        'uid': userCredential.user!.uid,
        'registrationCode': _regCodeController.text,
        'fullName': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'certificateAttached': true,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ምዝገባው በFirebase ተሳክቷል! አሁን ይግቡ።')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'የምዝገባ ስህተት ተፈጥሯል')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('የተማሪዎች ምዝገባ')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: _regCodeController,
                labelText: 'የሬጅስትሬሽን ኮድ',
                prefixIcon: Icons.qr_code,
                readOnly: true,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: _nameController,
                labelText: 'ሙሉ ስም',
                prefixIcon: Icons.person,
                validator: (v) => v!.isEmpty ? 'እባክዎን ስምዎን ያስገቡ' : null,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: _emailController,
                labelText: 'ትክክለኛ ኢሜይል',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'እባክዎን ኢሜይል ያስገቡ';
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(
                      v)) {
                    return 'እባክዎን ትክክለኛ ኢሜይል ያስገቡ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: _passwordController,
                labelText: 'ፓስወርድ ይምረጡ',
                prefixIcon: Icons.lock,
                obscureText: true,
                validator: (v) =>
                v != null && v.length < 6 ? 'ፓስወርድ ቢያንስ 6 ፊደላት መሆን አለበት' : null,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    const Text(
                      'የስርተፊኬት / የውጤት ፎቶ ያስገቡ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() => _certificateUploaded = true);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('የስርተፊኬት ፎቶ ተመርጧል!')),
                        );
                      },
                      icon: const Icon(Icons.upload_file),
                      label: Text(
                          _certificateUploaded ? 'ፎቶ ተያይዟል ✓' : 'ፎቶ ይምረጡ'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.green,
                ),
                onPressed: _registerUser,
                child: const Text('ምዝገባውን ጨርስ',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}