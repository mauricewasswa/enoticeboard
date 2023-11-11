import 'package:flutter/material.dart';
import '../firebase/posts_model.dart';

class NewsDetailPage extends StatelessWidget {
  final Post post; // Declare a property to store the Post

  // Constructor to receive the Post when creating NewsDetailPage
  NewsDetailPage({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff76ca71),
        title: Text('Notice Detail'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          padding: EdgeInsets.all(20),
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
                backgroundColor: Color(0xff76ca71),
                backgroundImage: NetworkImage(post.profImgUrl),
                radius: 24,
              ),
              SizedBox(height: 16),

              // Title, Name, and Level
              Row(
                children: [
                  Text(post.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(' • '),
                  Text('${post.fname} ${post.lname}', style: TextStyle(fontSize: 16)),
                  Text(' • '),
                  Text('${post.level}', style: TextStyle(fontSize: 16)),
                ],
              ),
              SizedBox(height: 8),

              // Date and Time
              Text('21-11-2023 • 09:23 AM', style: TextStyle(fontSize: 11, color: Color.fromRGBO(0, 0, 0, 1))),

              SizedBox(height: 8),
              Text('${post.header}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 1))),

              SizedBox(height: 8),
              Text('${post.desc}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Color.fromRGBO(0, 0, 0, 1))),


              SizedBox(height: 16),

              // Body of the Notice
              Text(
                post.content,
                style: TextStyle(fontSize: 12, color: Color.fromRGBO(0, 0, 0, 1)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
