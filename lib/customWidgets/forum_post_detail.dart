import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enoticeboard/customWidgets/forum_posts_page.dart';
import 'package:enoticeboard/customWidgets/reply_center.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../firebase/posts_model.dart';



class ForumPostDetail extends StatefulWidget {
  final String title;
  final String postId;
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
    required this.postId,
  });

  @override
  State<ForumPostDetail> createState() => _ForumPostDetailState();
}

class _ForumPostDetailState extends State<ForumPostDetail> {
  TextEditingController replyController = TextEditingController();
  User? currentUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      currentUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff76ca71),
        title: Text(widget.header),
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
                  backgroundImage: NetworkImage(widget.profImgUrl),
                  radius: 24,
                ),
                SizedBox(height: 16),

                // Title, Name, and Level
                Row(
                  children: [
                    Text(widget.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(' • '),
                    Text('${widget.fname} ${widget.lname}', style: TextStyle(fontSize: 16)),
                    Text(' • '),
                    Text('${widget.level}', style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(height: 8),

                // Date and Time
                Text('${_formatTimestamp(widget.time)}', style: TextStyle(fontSize: 11, color: Color.fromRGBO(0, 0, 0, 1))),

                SizedBox(height: 8),

                Text('${widget.header}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 1))),

                SizedBox(height: 8),
                Text('${widget.desc}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Color.fromRGBO(0, 0, 0, 1))),

                SizedBox(height: 16),

                // Body of the Notice
                Text(
                  widget.content,
                  style: TextStyle(fontSize: 12, color: Color.fromRGBO(0, 0, 0, 1)),
                ),

                SizedBox(height: 16),
                // Image Widget with Error Handling
                _buildImageWidget(),
                SizedBox(height: 16),
                // UI for adding a reply
                TextField(
                  controller: replyController,
                  decoration: InputDecoration(
                    hintText: 'Add a reply...',
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xff222222)),
                  ),
                  onPressed: () {
                    // Handle the submission of the reply
                    String replyText = replyController.text;
                    if (replyText.isNotEmpty) {
                      submitReply(replyText);
                      // Clear the text field after submission
                      replyController.clear();
                    }
                  },
                  child: Text('Submit Reply'),
                ),
                SizedBox(height: 16),
                // Display replies
                buildRepliesWidget(),
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

  Widget _buildImageWidget() {
    try {
      if (this.widget.postdoc != null && this.widget.postdoc.isNotEmpty) {
        print('Image URL: ${widget.postdoc}'); // Print the image URL

        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Image.network(
            this.widget.postdoc,
            width: 350,
            height: 400,
            fit: BoxFit.cover,
          ),
        );
      }
    } catch (error) {
      print('Error loading image: $error');
      // You can still print the image URL even in case of an error
      print('Image URL: ${widget.postdoc}');

      // You can return a placeholder or an error message widget
      return Container(
        width: 350,
        height: 400,
        color: Colors.grey, // Placeholder color or an error color
        child: Center(
          child: Text('Image Error'), // Display an error message
        ),
      );
    }

    // Return an empty widget if there is no image
    return SizedBox.shrink();
  }



  // Method to submit a reply to Firestore
  void submitReply(String replyText) {
    CollectionReference repliesCollection = FirebaseFirestore.instance.collection('replies');
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

    // Fetch user information from Firestore
    usersCollection.where('userId', isEqualTo: currentUser!.uid).get().then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there is only one document matching the user ID
        Map<String, dynamic>? userData = querySnapshot.docs.first.data() as Map<String, dynamic>?;

        if (userData != null) {
          // Create a new reply document
          Map<String, dynamic> newReply = {
            'postId': widget.postId,
            'replyText': replyText,
            'timestamp': FieldValue.serverTimestamp(),
            'userId': currentUser!.uid,
            'userName': '${userData['fname'] ?? 'Unknown'} ${userData['lname'] ?? 'Unknown'}',
            'userTitle': userData['title'] ?? 'Unknown Title',
            'userLevel': userData['level'] ?? 'Unknown Level',
            'userProfilePic': userData['profImg'] ?? 'default_profile_pic_url',
          };

          // Add the new reply to the 'replies' collection
          repliesCollection.add(newReply).then((value) {
            // Print a success message if the reply is added successfully
            print('Reply submitted successfully: $newReply');
          }).catchError((error) {
            // Print an error message if there's an issue with adding the reply
            print('Error submitting reply: $error');
          });
        } else {
          print('User data is null');
        }
      } else {
        print('User not found in Firestore');
      }
    });
  }

  // Method to fetch and display replies
  Widget buildRepliesWidget() {
    CollectionReference repliesCollection = FirebaseFirestore.instance.collection('replies');

    return StreamBuilder<QuerySnapshot>(
      stream: repliesCollection.where('postId', isEqualTo: widget.postId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        List<Widget> replyWidgets = [];

        // Iterate through the replies and create a widget for each
        for (QueryDocumentSnapshot replySnapshot in snapshot.data!.docs) {
          Map<String, dynamic> replyData = replySnapshot.data() as Map<String, dynamic>;

          // Create a widget for displaying a reply
          Widget replyWidget = ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(replyData['userProfilePic']),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${replyData['userName']}', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('${replyData['userTitle']} • ${replyData['userLevel']}'),
              ],
            ),
            subtitle: Text(replyData['replyText']),
            trailing: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReplyCenter(
                        title: replyData['replyText'],
                        replyContent: replyData['replyText'],
                        replyId: replySnapshot.id,
                        uname: replyData['userName'],
                        usertitle: replyData['userTitle'],
                        level: replyData['userLevel'],
                        profPic: replyData['userProfilePic'],)
                  ),

                );
              },
              child: Text("Reply"),),

          );

          replyWidgets.add(replyWidget);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Replies',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Display the list of reply widgets
            ...replyWidgets,
          ],
        );
      },
    );
  }
}
