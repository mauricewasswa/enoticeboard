import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ForumPostDetail extends StatelessWidget {
  final String title;
  final String content;
  final String fname;
  final String lname;
  final String level;
  final String header;
  final String desc;
  final String profImgUrl;
  final Timestamp time;
  final postdoc;
  final String forumId;
  final String forumTitle;

  const ForumPostDetail({
    required this.title,
    required this.content,
    required this.fname,
    required this.lname,
    required this.level,
    required this.header,
    required this.desc,
    required this.profImgUrl,
    required this.time,
    this.postdoc,
    required this.forumId,
    required this.forumTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff76ca71),
        title: Text(header),
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
                  backgroundImage: NetworkImage(profImgUrl),
                  radius: 24,
                ),
                SizedBox(height: 16),

                // Title, Name, and Level
                Row(
                  children: [
                    Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(' • '),
                    Text('$fname $lname', style: TextStyle(fontSize: 16)),
                    Text(' • '),
                    Text('$level', style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(height: 8),

                // Date and Time
                Text('${_formatTimestamp(time)}', style: TextStyle(fontSize: 11, color: Color.fromRGBO(0, 0, 0, 1))),

                SizedBox(height: 8),

                Text('$header', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 1))),

                SizedBox(height: 8),
                Text('$desc', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Color.fromRGBO(0, 0, 0, 1))),

                SizedBox(height: 16),

                // Body of the Notice
                Text(
                  content,
                  style: TextStyle(fontSize: 12, color: Color.fromRGBO(0, 0, 0, 1)),
                ),

                SizedBox(height: 16),
                if (this.postdoc != null && this.postdoc.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image.network(
                      this.postdoc, // Assuming postdoc contains the URL of the attached image
                      width: 350, // Set the width of the image as per your requirement
                      height: 400, // Set the height of the image as per your requirement
                      fit: BoxFit.cover, // You can customize the BoxFit property based on your needs
                    ),
                  ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formattedDate = DateFormat('dd-MM-yyyy • hh:mm a').format(dateTime);
    return formattedDate;
  }
}
