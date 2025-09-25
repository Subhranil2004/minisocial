import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('U S E R S'),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(), // .where('email', isNotEqualTo: FirebaseAuth.instance.currentUser?.email)
        builder: (context, snapshot) {
        // any errors
        if(snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        // loading state
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if(snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No users found'));
        }

        // get all users except current user
          if (snapshot.hasData) {
            var users = snapshot.data?.docs ?? [];

            if (users.isEmpty) {
              return const Center(child: Text('No other users found'));
            }

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                var user = users[index];
                return ListTile(
                  title: Text(user['username'] ?? 'No Name'),
                  subtitle: Text(user['email'] ?? 'No Email'),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
