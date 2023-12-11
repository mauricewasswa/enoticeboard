import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../firebase/posts_model.dart';

class NewsDetailPage extends StatefulWidget {
  final Post post;

  NewsDetailPage({required this.post});

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
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
        title: Text(widget.post.header),
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
                CircleAvatar(
                  backgroundColor: Color(0xff76ca71),
                  backgroundImage: NetworkImage(widget.post.profImgUrl),
                  radius: 24,
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(widget.post.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(' • '),
                    Text('${widget.post.fname} ${widget.post.lname}', style: TextStyle(fontSize: 16)),
                    Text(' • '),
                    Text('${widget.post.level}', style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(height: 8),
                Text('${_formatTimestamp(widget.post.time)}', style: TextStyle(fontSize: 11, color: Color.fromRGBO(0, 0, 0, 1))),
                SizedBox(height: 8),
                Text('${widget.post.header}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 1))),
                SizedBox(height: 8),
                Text('${widget.post.desc}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Color.fromRGBO(0, 0, 0, 1))),
                SizedBox(height: 16),
                Text(
                  widget.post.content,
                  style: TextStyle(fontSize: 12, color: Color.fromRGBO(0, 0, 0, 1)),
                ),
                SizedBox(height: 16),
                if (widget.post.postdoc != null && widget.post.postdoc.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image.network(
                      widget.post.postdoc!,
                      width: 350,
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                  ),
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
            'postId': widget.post.postId,
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
      stream: repliesCollection.where('postId', isEqualTo: widget.post.postId).snapshots(),
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
