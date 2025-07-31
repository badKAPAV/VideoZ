import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TestAuthScreen extends StatefulWidget {
  const TestAuthScreen({super.key});

  @override
  State<TestAuthScreen> createState() => _TestAuthScreenState();
}

class _TestAuthScreenState extends State<TestAuthScreen> {
  String _status = 'Ready to test...';
  bool _isLoading = false;

  Future<void> testRegistration() async {
    setState(() {
      _isLoading = true;
      _status = 'Attempting to register new user...';
    });

    final email = 'testuser_${DateTime.now().millisecondsSinceEpoch}@test.com';
    final password = 'password123';

    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      setState(() {
        _status =
            'SUCCESS! User created in Firebase Auth.\nUID: ${userCredential.user?.uid}';
      });
      print(_status);
    } catch (e) {
      setState(() {
        _status = 'FAILED! Error: ${e.toString()}';
      });
      print(_status);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auth Test')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Status:\n$_status',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: testRegistration,
                  child: const Text('Run Registration Test'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
