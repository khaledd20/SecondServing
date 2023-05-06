//profile_screen.dart
import 'package:flutter/material.dart';
import 'main.dart';
import 'services/firebase_auth_service.dart';

class ProfileScreen extends StatelessWidget {
  final String user;
  final String email;

  ProfileScreen({required this.user, required this.email});
  final firebaseAuth = FirebaseAuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors
                  .grey, // Set a background color for the anonymous user icon
              child: Icon(
                Icons.account_circle,
                size: 80,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Username: $user',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Email: $email',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                firebaseAuth.signOut();
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
