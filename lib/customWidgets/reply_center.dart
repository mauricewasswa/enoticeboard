import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';

class ReplyCenter extends StatefulWidget {
  ReplyCenter({
    Key? key,
    required this.title,
    required this.replyContent,
    required this.replyId,
    required this.uname,
    required this.usertitle,
    required this.level,
    required this.profPic,
  }) : super(key: key);

  final String title;
  final String replyContent;
  final String replyId;
  final String uname;
  final String usertitle;
  final String level;
  final String profPic;

  @override
  _ReplyCenterState createState() => _ReplyCenterState();
}

class _ReplyCenterState extends State<ReplyCenter> {
  TextEditingController _replyController = TextEditingController();
  CustomUser? _currentUser; // Variable to store current user information

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('userId', isEqualTo: user.uid)
          .limit(1)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        DocumentSnapshot userData = userSnapshot.docs.first;

        // Check if 'fname' and 'lname' fields exist before accessing them
        String? firstName = userData['fname'];
        String? lastName = userData['lname'];

        setState(() {
          _currentUser = CustomUser(
            uid: user.uid,
            displayName: (firstName != null && lastName != null)
                ? '$firstName $lastName'
                : null,
            email: user.email,
            photoURL: userData['profImg'],
            level: userData['level']
          );
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: CommentTreeWidget<Comment, Comment>(
                Comment(
                    avatar: 'null',
                    userName: 'null',
                    content: 'felangel made felangel/cubit_and_beyond public '),
                [
                  Comment(
                      avatar: 'null',
                      userName: 'null',
                      content: 'A Dart template generator which helps teams'),
                ],
                treeThemeData:
                TreeThemeData(lineColor: Colors.green[500]!, lineWidth: 3),
                avatarRoot: (context, data) => PreferredSize(
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(widget.profPic),
                  ),
                  preferredSize: Size.fromRadius(18),
                ),
                avatarChild: (context, data) => PreferredSize(
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.grey,
                    backgroundImage: AssetImage('assets/av1.png'),
                  ),
                  preferredSize: Size.fromRadius(12),
                ),
                contentChild: (context, data) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Edwine Kasumba',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              '${data.content}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      DefaultTextStyle(
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold),
                        child: Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 8,
                              ),
                              TextButton(
                                onPressed: () {
                                  // Set the reply text field active
                                  _showReplyTextField(data);
                                },
                                child: Text("Reply"),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
                contentRoot: (context, data) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.usertitle +
                                      " " +
                                      widget.uname,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(' • '),
                                Text(
                                  widget.level,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                Text(' • '),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              '${widget.replyContent}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      DefaultTextStyle(
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold),
                        child: Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child: TextButton(
                                  onPressed: () {
                                    // Set the reply text field active
                                    _showReplyTextField(data);
                                  },
                                  child: Text("Reply"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
          ),
          // Reply Text Field
          Container(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _replyController,
              decoration: InputDecoration(
                hintText: 'Write a reply...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    if (_currentUser != null) {
                      await _submitReplyToDatabase(
                        widget.replyId,
                        _replyController.text,
                        _currentUser!,
                      );
                    }
                    String replyText = _replyController.text;
                    // Add your logic for handling the reply text
                    print('Reply: $replyText');
                    // Clear the text field after sending the reply
                    _replyController.clear();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showReplyTextField(Comment data) {
    // Set the focus on the text field and show the keyboard
    _replyController.text = ''; // Clear any previous text
    FocusScope.of(context).requestFocus(FocusNode());
  }

  Future<void> _submitReplyToDatabase(String replyId, String replyText, CustomUser user) async {
    try {
      if (user == null) {
        print('Error: User is null');
        return;
      }

      CollectionReference commentReplies = FirebaseFirestore.instance.collection('comment_replys');

      await commentReplies.add({
        'replyId': replyId,
        'replyText': replyText,
        'userId': user.uid,
        'userEmail': user.email,
        'displayName' : user.displayName,
        'imgUrl' : user.photoURL,
        'level' : user.level,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Successful submission, handle accordingly
      print('Reply submitted successfully');
    } catch (e) {
      // Handle exceptions
      print('Error submitting reply: $e');
    }
  }

}

class CustomUser {
  final String uid;
  final String? displayName;
  final String? email;
  final String? photoURL;
  final String? level;

  CustomUser({
    required this.uid,
    this.displayName,
    this.email,
    this.photoURL,
    this.level
  });


}

class CommentReplys{
  late final String? ruid;
  late final String? rdisplayName;
  late final String? remail;
  late final String? rphotoURL;
  late final String? rlevel;

  CommentReplys({
    this.rdisplayName,
    this.remail,
    this.rlevel,
    this.rphotoURL,
    this.ruid

});


  Future<List<DocumentSnapshot>> fetchReplies(String commentId) async {
    // Replace 'your_collection_path' with the actual path to your collection
    //String collectionPath = 'your_collection_path/comment_replies';

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("comment_replys")
          .where('replyId', isEqualTo: commentId)
          .get();

      List<DocumentSnapshot> replies = querySnapshot.docs;
      return replies;
    } catch (e) {
      print('Error fetching replies: $e');
      return [];
    }
  }

  void main() async {
    // Replace 'your_comment_id' with the actual comment ID for which you want to fetch replies
    String commentId = 'hYzf8mCJQjkiCh5ZxBkM';

    List<DocumentSnapshot> replies = await fetchReplies(commentId);

    if (replies.isNotEmpty) {
      for (var reply in replies) {
        print('Reply: ${reply.data()}');
      }
    } else {
      print('No replies found for comment $commentId');
    }
  }
}
