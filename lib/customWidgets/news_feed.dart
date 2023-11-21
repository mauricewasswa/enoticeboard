// news_feed.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../firebase/posts_model.dart';
import 'news_details.dart';

class NewsFeedItem extends StatelessWidget {
  final Post post; // Declare a property to store the Post

  // Constructor to receive the Post when creating NewsFeedItem
  NewsFeedItem({required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return NewsDetailPage(post: post); // Pass the post to NewsDetailPage
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
              backgroundImage: NetworkImage(post.profImgUrl),
              radius: 24,
            ),
            SizedBox(height: 16),

            // Title, Name, and Level
            Row(
              children: [
                Text(post.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(' • '),
                Text(post.fname + " " + post.lname, style: TextStyle(fontSize: 16)),
                Text(' • '),
                Text('${post.level}', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 8),

            // Date and Time
            Text(_formatTimestamp(post.time),style: TextStyle(fontSize: 11, color: Color.fromRGBO(0, 0, 0, 1))),

            SizedBox(height: 8),
            Text('${post.header}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 1))),

            SizedBox(height: 8),
            Text('${post.desc}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Color.fromRGBO(0, 0, 0, 1))),

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

  String _formatTimestamp(Timestamp timestamp) {
    // Customize the formatting based on your needs
    DateTime dateTime = timestamp.toDate();
    String formattedDate = DateFormat('dd-MM-yyyy • hh:mm a').format(dateTime);
    return formattedDate;
  }
}
