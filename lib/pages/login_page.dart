import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/helper/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  void login() async {
    // try signing in
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      
      // Ensure user document exists in Firestore
      await ensureUserDocument(userCredential);
      
    } on FirebaseAuthException catch (e) {
      // Log authentication errors for debugging
      print("Login failed: ${e.code}");
      if (context.mounted) {
        displayMessageToUser(e.code, context);
      }
    } catch (e) {
      // Log unexpected errors
      print("Login error: $e");
      if (context.mounted) {
        displayMessageToUser(e.toString(), context);
      }
    }
  }

  Future<void> ensureUserDocument(UserCredential userCredential) async {
    if (userCredential.user != null) {
      String email = userCredential.user!.email!;
      
      // Check if user document already exists
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(email)
          .get();
      
      // If user document doesn't exist, create it
      if (!userDoc.exists) {
        print("USER DOC NOT FOUND!");
      //   await FirebaseFirestore.instance
      //       .collection('Users')
      //       .doc(email)
      //       .set({
      //     'username': email.split('@')[0], // Use email prefix as default username
      //     'email': email,
      //     'uid': userCredential.user!.uid,
      //     'createdAt': FieldValue.serverTimestamp(),
      //   });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                Icon(Icons.person, size: 100, color: Theme.of(context).colorScheme.inversePrimary),
                const SizedBox(height: 20),
                // appname
                Text('M I N I S O C I A L', style: TextStyle(fontSize: 20)),
                const SizedBox(height: 40),
                // email
                MyTextField(hintText: 'Email', obscureText: false, controller: emailController),
                const SizedBox(height: 20),
            
                // password
                MyTextField(hintText: 'Password', obscureText: true, controller: passwordController),
                const SizedBox(height: 10),
                // forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text('Forgot Password?', style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // signin button
                MyButton(text: 'Sign In', onTap: login),
                const SizedBox(height: 20),
                // don't have an account? signup here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?", style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(' Register Here', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
