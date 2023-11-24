import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForumPostDetail extends StatelessWidget {
  const ForumPostDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff76ca71),
        title: Text('Notice Detail'),
      ),
      body: SingleChildScrollView(
        child: Center(
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
                  backgroundImage: NetworkImage("https://www.istockphoto.com/photo/close-up-profile-of-handsome-young-man-gm1377471505-442577091?utm_campaign=srp_photos_top&utm_content=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fprofile&utm_medium=affiliate&utm_source=unsplash&utm_term=profile%3A%3A%3A"),
                  radius: 24,
                ),
                SizedBox(height: 16),

                // Title, Name, and Level
                Row(
                  children: [
                    Text("post.title", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(' • '),
                    Text('${"Fname"} ${"Lname"}', style: TextStyle(fontSize: 16)),
                    Text(' • '),
                    Text('${"Level"}', style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(height: 8),

                // Date and Time
                Text('22-22-2222', style: TextStyle(fontSize: 11, color: Color.fromRGBO(0, 0, 0, 1))),

                SizedBox(height: 8),



                SizedBox(height: 8),

                Text('${"post.header"}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 1))),

                SizedBox(height: 8),
                Text('${"post.desc"}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Color.fromRGBO(0, 0, 0, 1))),

                SizedBox(height: 16),

                // Body of the Notice
                Text(
                  "post.content",
                  style: TextStyle(fontSize: 12, color: Color.fromRGBO(0, 0, 0, 1)),
                ),

                SizedBox(height: 16),
                // Document Attached Icon
                // if (post.postdoc != null && post.postdoc.isNotEmpty)
                //   Icon(
                //     Icons.attach_file, // You can replace this with the actual icon you want
                //     color: Colors.blue, // You can customize the icon color
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
