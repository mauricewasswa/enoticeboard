import 'package:flutter/material.dart';

import 'forum_posts_page.dart';

class ForumWidget extends StatelessWidget {
  final String title;
  final String description;
  final int notificationCount;
  final String forumId;

  ForumWidget({
    required this.title,
    required this.description,
    required this.notificationCount,
    required this.forumId
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the page displaying posts for this forum
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              // Replace 'PostsPage' with the actual page where you display posts
              return ForumPostsPage(forumTitle: title, forumId: forumId,);
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(description),
              ],
            ),
            CircleAvatar(
              backgroundColor: Colors.red,
              radius: 16.0,
              child: Text(
                notificationCount.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
