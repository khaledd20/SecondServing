//main.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'views/profile_screen.dart';
import 'views/register_screen.dart';
import 'services/firebase_auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyCHY9o8tJyXwlRwRWciDTDuP0vMktvsD1M",
        appId: "1:566371582218:web:d583fb46a9874aeb967af3",
        messagingSenderId: "566371582218",
        projectId: "secondserving-ef1f1"),
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    ),
  );
}

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final firebaseAuth = FirebaseAuthService();
  void _login(BuildContext context) async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // TODO: Add login functionality
    // You can add your login logic here
    // For example, you can validate the username and password
    // against a stored list of credentials or an API.
    firebaseAuth.signInWithEmailAndPassword(username, password).then((value) {
      final snackBar = SnackBar(content: Text(value.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
    // Assuming login is successful, navigate to the profile screen
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(
              user: username,
              email: 'example@example.com', // Replace with the user's email
            ),
          ),
        );
      }
    });
  }

  void _navigateToRegisterScreen(BuildContext context) {
    // Navigate to the RegisterScreen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Second Serving',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login'),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () => _navigateToRegisterScreen(context),
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
