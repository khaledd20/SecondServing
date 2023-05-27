import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../views/profile_screen.dart';

class FoodReceiverScreen extends StatefulWidget {
  @override
  _FoodReceiverScreenState createState() => _FoodReceiverScreenState();
}

class _FoodReceiverScreenState extends State<FoodReceiverScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  late TextEditingController _searchController;
  String? _searchTerm;
  String? _locationFilter;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> foodList = [
      {
    'name': 'Pizza',
    'photo': 'assets/images/pizza.jpg',
    'distance': '2 km away',
  },
  {
    'name': 'Burger',
    'photo': 'assets/images/burger.jpg',
    'distance': '3 km away',
  },
  {
    'name': 'Sushi',
    'photo': 'assets/images/sushi.jpg',
    'distance': '1 km away',
  },
  {
    'name': 'Pasta',
    'photo': 'assets/images/pasta.jpg',
    'distance': '4 km away',
  },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Food Receiver'),
            TextButton(
              onPressed: () {
                // TODO: Implement history functionality
              },
              child: Text(
                'History',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.account_circle,
                      size: 60,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Username: ${user?.displayName ?? "N/A"}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Email: ${user?.email ?? "N/A"}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Profile'),
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(user: user!),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Chat'),
              leading: Icon(Icons.chat),
              onTap: () {
                // TODO: Implement the chat functionality
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: Text('Sign Out'),
              leading: Icon(Icons.logout),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: foodList.length,
              itemBuilder: (context, index) {
                final food = foodList[index];
                final name = food['name'];
                final photo = food['photo'];
                final distance = food['distance'];

                return ListTile(
                  leading: Image.asset(
                    photo,
                    width: 100,
                    height: 100,
                    ),
                  title: Text(name),
                  subtitle: Text(distance),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement plus button functionality
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
