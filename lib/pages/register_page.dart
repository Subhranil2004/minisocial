import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/helper/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void registerUser() async {
    // // show loading circle
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return const Center(child: CircularProgressIndicator());
    //   },
    // );

    // password confirmation
    if (passwordController.text != confirmPasswordController.text) {
      // pop loading circle
      // Navigator.pop(context);
      // show error message
      displayMessageToUser('Passwords do not match', context);
      return;
    } else {
      // try creating user
      try {
        // create user
        UserCredential? userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // create a user doc and add to firestore
        await createUserDocument(userCredential);

      } on FirebaseAuthException catch (e) {
        // show error message
        if (context.mounted) {
          displayMessageToUser(e.code, context);
        }
      } catch (e) {
        if (context.mounted) {
          displayMessageToUser(e.toString(), context); // Catch any other errors
        }
      }
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential) async {
    // Add additional user details to Firestore
    if (userCredential != null && userCredential.user != null) {
      String username = usernameController.text;
      String email = emailController.text;
      

      // Call the helper function to create the user document
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(email) // Use email as the document ID
          .set({
        'username': username,
        'email': email,
        'uid': userCredential.user!.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
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
                // username
                MyTextField(hintText: 'Username', obscureText: false, controller: usernameController),
                const SizedBox(height: 20),
            
                // email
                MyTextField(hintText: 'Email', obscureText: false, controller: emailController),
                const SizedBox(height: 20),
            
                // password
                MyTextField(hintText: 'Password', obscureText: true, controller: passwordController),
                const SizedBox(height: 20),
            
                // confirm password
                MyTextField(hintText: 'Confirm Password', obscureText: true, controller: confirmPasswordController),
                const SizedBox(height: 20),
            
                // register button
                MyButton(text: 'Register', onTap: registerUser),
                const SizedBox(height: 20),
                // already have an account? login here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?", style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(' Login Here', style: TextStyle(fontWeight: FontWeight.bold)),
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
