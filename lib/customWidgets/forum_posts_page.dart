import 'package:enoticeboard/customWidgets/forum_post_detail.dart';
import 'package:flutter/material.dart';

import '../popmenu/add_members.dart';
import '../popmenu/forum_settings.dart';

class PostsPage extends StatelessWidget {
  final String forumTitle;

  PostsPage({required this.forumTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff76ca71),
        title: Text('$forumTitle'),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle menu item selection
              if (value == 'addMembers') {
                // Navigate to Add Members screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddMembersPage(forumTitle : forumTitle,)),
                );
              } else if (value == 'settings') {
                // Navigate to Settings screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForumSettingsPage()),
                );
              }
              // Add more conditions for other menu items
            },

            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'addMembers',
                child: Text('Add Members'),
              ),
              PopupMenuItem<String>(
                value: 'settings',
                child: Text('Settings'),
              ),
              // Add more menu items as needed
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          // Example post widgets, you can replace this with your actual post data
          PostWidget(author: 'User1', content: 'This is the first post in $forumTitle.'),
          PostWidget(author: 'User2', content: 'Another post in $forumTitle.'),
          // Add more post widgets as needed
        ],
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final String author;
  final String content;

  PostWidget({required this.author, required this.content});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ForumPostDetail(); // Pass the post to ForumPostDetail
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(5, 7),
              blurRadius: 15,
            ),
          ],
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture
            CircleAvatar(
              backgroundImage: NetworkImage('https://www.istockphoto.com/photo/close-up-profile-of-handsome-young-man-gm1377471505-442577091?utm_campaign=srp_photos_top&utm_content=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fprofile&utm_medium=affiliate&utm_source=unsplash&utm_term=profile%3A%3A%3A'),
              radius: 24,
            ),
            SizedBox(height: 16),

            // Title, Name, and Level
            Row(
              children: [
                Text("Mr.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(' • '),
                Text("Myname" + " " + "Lastname", style: TextStyle(fontSize: 16)),
                Text(' • '),
                Text('${"Level"}', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 8),

            // Date and Time
            Text("22-22-2222", style: TextStyle(fontSize: 11, color: Color.fromRGBO(0, 0, 0, 1))),

            SizedBox(height: 8),
            Text('${"This Is Our Forum"}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 1))),

            SizedBox(height: 8),
            Text('${"Lorem Ipsum Dolor"}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Color.fromRGBO(0, 0, 0, 1))),

            SizedBox(height: 16),

            // Body of the Notice
            // Text(
            //   post.content,
            //   style: TextStyle(fontSize: 12, color: Color.fromRGBO(0, 0, 0, 1)),
            // ),
          ],
        ),
      ),
    );
  }
}
