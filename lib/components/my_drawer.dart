import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  logout() async {
    // Implement your logout logic here
    await FirebaseAuth.instance.signOut();
  }
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: Column(
          children: [
            // drawer header
            DrawerHeader(
              child: Icon(Icons.account_circle, size: 100, color: Theme.of(context).colorScheme.inversePrimary)
            ),
            SizedBox(height: 50),
            // home
            ListTile(
              leading: Icon(Icons.home, color: Theme.of(context).colorScheme.inversePrimary),
              title: Text('H O M E', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
        
            // profile
            ListTile(
              leading: Icon(Icons.person, color: Theme.of(context).colorScheme.inversePrimary),
              title: Text('P R O F I L E', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
              onTap: () {
                // pop drawer
                Navigator.pop(context);
                // Navigate to profile page
                Navigator.pushNamed(context, '/profile_page');
              },
            ),
        
            // user
            ListTile(
              leading: Icon(Icons.group, color: Theme.of(context).colorScheme.inversePrimary),
              title: Text('U S E R S', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
              onTap: () {
                // pop drawer
                Navigator.pop(context);
                // Navigate to user page
                Navigator.pushNamed(context, '/users_page');
              },
            ),

            // SizedBox(height: 400),
            // logout
            ListTile(
              leading: Icon(Icons.logout, color: Theme.of(context).colorScheme.inversePrimary),
              title: Text('L O G O U T', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
              onTap: () {
                // pop drawer
                Navigator.pop(context);
                logout();
                // Navigate to login page
                Navigator.pushNamed(context, '/login_register_page');
              },
            ),
        
          ],
        ),
      ),
    );
  }
}