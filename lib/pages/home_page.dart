import 'package:chat_app/components/my_drawer.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/components/my_post_card.dart';
import 'package:chat_app/database/firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final database = FireStoreDatabase();

  // text controller
  final TextEditingController newPostController = TextEditingController();

  void postMessage()  {
    String newPost = newPostController.text;
    if (newPost.isNotEmpty) {
      database.addPost(newPost);

      // clear the controller
      newPostController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('W A L L'),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // list of posts (placeholder)
          Expanded(
            child: StreamBuilder(
              stream: database.getPosts(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                // show loading indicator while waiting for data
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                // get all posts
                // var posts = snapshot.data ?? []; // <--- safer way
                final posts = snapshot.data!; // <--- non-null assertion

                // no data
                if (posts.isEmpty) {
                  return const Center(
                    // padding: EdgeInsets.all(16.0),
                    child: Text('No posts yet...Post Something!')
                  );
                }

                // return as a list
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    // get each individual post
                    final post = posts[index];

                    // get data from each post
                    String user = post['sender'];
                    String message = post['message'];
                    // Timestamp time = post['timestamp'];

                    // return as a card
                    return MyPostCard(
                      title: message,
                      subtitle: user,
                    );


                  },
                );


              },
            ),
          ),
          // textbox at bottom
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: MyTextField(
                      hintText: 'Say something...',
                      obscureText: false,
                      controller: newPostController,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8.0, right: 4.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.send, color: Theme.of(context).colorScheme.inversePrimary),
                    onPressed: postMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: MyDrawer(),
    );
  }
}