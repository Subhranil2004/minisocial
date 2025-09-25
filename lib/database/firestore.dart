/*
Collection: 'Posts'
Each post document:
  'sender': sender email
  'message': message text
  'timestamp': timestamp
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreDatabase {
  // get collection of posts
  CollectionReference getPostsCollection() {
    return FirebaseFirestore.instance.collection('Posts');
  }

  // post a message
  Future<void> addPost(String message) async {
    // Get current user dynamically
    User? currentUser = FirebaseAuth.instance.currentUser;
    
    if (currentUser != null) {
      await getPostsCollection().add({
        'sender': currentUser.email,
        'message': message,
        'timestamp': Timestamp.now(),
      });
    }
  }

  // read posts from database. Stream to continuously listen for updates
  Stream<List<Map<String, dynamic>>> getPosts() {
    return getPostsCollection()
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());
  }
}