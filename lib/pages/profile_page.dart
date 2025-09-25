import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  // current logged in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // future to get user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    if (currentUser != null) {
      return await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser!.email)
          .get();
    }
    throw Exception('User not logged in');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('P R O F I L E'),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: getUserDetails(),
          builder: (context, snapshot) {
            
            if (snapshot.connectionState == ConnectionState.waiting) { // loading state
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) { // error state
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData && snapshot.data!.exists) { // data state
              var userData = snapshot.data!.data();
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_circle, size: 100, color: Theme.of(context).colorScheme.inversePrimary),
                  const SizedBox(height: 20),
                  Text('Username: ${userData?['username'] ?? 'N/A'}'),
                  Text('Email: ${userData?['email'] ?? 'N/A'}'),
                ],
              );
            } else {
              return const Text('No user data found');
            }
          },
        ),
      ),
    );
  }
}