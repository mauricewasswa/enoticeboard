import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ForumSettingsPage(
        forumId: 'your_forum_id',
        forumTitle: 'Your Forum',
        forumDesc: 'Description of Your Forum',
      ),
      debugShowCheckedModeBanner: false, // Set to false to hide debug banner
    );
  }
}

class ForumSettingsPage extends StatelessWidget {
  final String forumId;
  final String forumTitle;
  final String forumDesc;

  ForumSettingsPage({
    required this.forumId,
    required this.forumTitle,
    required this.forumDesc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff76ca71),
        title: Text('Forum Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Forum Title
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '$forumTitle',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          // Forum Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '$forumDesc',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Divider(),

          // Show Members
          Expanded(child: MembersList(forumId: forumId)),
          Divider(),
          // Remove User or Make Admin
        ],
      ),
    );
  }
}

class MembersList extends StatelessWidget {
  final String forumId;

  MembersList({required this.forumId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('forums').doc(forumId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff76ca71)), // Set color
              strokeWidth: 3.0, // Set stroke width
            ),
          );
        }

        var forumData = snapshot.data?.data() as Map<String, dynamic>?;

        if (forumData == null || !forumData.containsKey('members')) {
          return Text('No members available.');
        }

        var members = List<String>.from(forumData['members']);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Members',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FutureBuilder<List<User>>(
                  future: getUserDetailsForMembers(members),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xff76ca71)), // Set color
                          strokeWidth: 3.0, // Set stroke width
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    var users = snapshot.data ?? [];

                    if (users.isEmpty) {
                      return Text('No members available.');
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        var user = users[index];
                        return ListTile(
                          title: Text('${user.fname} ${user.lname}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Title: ${user.title}'),
                              Text('Level: ${user.level}'),
                            ],
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user.profImg),
                          ),
                          onLongPress: () {
                            _showPopupMenu(context, user);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<List<User>> getUserDetailsForMembers(List<String> memberIds) async {
    List<User> users = [];

    try {
      for (String memberId in memberIds) {
        QuerySnapshot userQuery =
        await FirebaseFirestore.instance.collection('users').where('userId', isEqualTo: memberId).get();

        if (userQuery.docs.isNotEmpty) {
          DocumentSnapshot userSnapshot = userQuery.docs.first;
          User user = User.fromMap(userSnapshot.data() as Map<String, dynamic>);
          users.add(user);
        }
      }
    } catch (e) {
      print('Error retrieving user information: $e');
    }

    return users;
  }
}

class User {
  final String userId;
  final String email;
  final String fname;
  final String lname;
  final String title;
  final String level;
  final String profImg;

  User({
    required this.userId,
    required this.email,
    required this.fname,
    required this.lname,
    required this.title,
    required this.level,
    required this.profImg,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'],
      email: map['email'],
      fname: map['fname'],
      lname: map['lname'],
      title: map['title'],
      level: map['level'],
      profImg: map['profImg'],
    );
  }
}

// Add this function to show the popup menu
void _showPopupMenu(BuildContext context, User user) async {
  final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
  final RelativeRect position = RelativeRect.fromRect(
    Rect.fromPoints(
      Offset.zero,
      overlay.localToGlobal(overlay.size.bottomLeft(Offset.zero)),
    ),
    Offset.zero & overlay.size,
  );

  await showMenu(
    context: context,
    position: position,
    items: [
      PopupMenuItem(
        value: 'makeAdmin',
        child: Text('Make Admin'),
      ),
      PopupMenuItem(
        value: 'remove',
        child: Text('Remove'),
      ),
      PopupMenuItem(
        value: 'removeAdmin',
        child: Text('Remove as Admin'),
      ),
    ],
  ).then((value) {
    if (value != null) {
      handleMenuSelection(value, user);
    }
  });
}

// Add this function to handle menu item selection
void handleMenuSelection(String value, User user) {
  switch (value) {
    case 'makeAdmin':
    // Implement logic to make the user an admin
      break;
    case 'remove':
    // Implement logic to remove the user
      break;
    case 'removeAdmin':
    // Implement logic to remove the user as admin
      break;
  }
}
