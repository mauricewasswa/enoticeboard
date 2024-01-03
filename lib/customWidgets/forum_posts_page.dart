import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enoticeboard/customWidgets/forum_post_detail.dart';
import 'package:flutter/material.dart';

import '../popmenu/add_members.dart';
import '../popmenu/forum_settings.dart';
import 'forum_add_notice.dart';

class ForumPostsPage extends StatelessWidget {
  final String forumTitle;
  final String forumId;

  ForumPostsPage({required this.forumTitle, required this.forumId});

  @override
  Widget build(BuildContext context) {
    CollectionReference postsCollection = FirebaseFirestore.instance.collection('forumposts');

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return ForumAddNotice();
              },
            ),
          );
        },
        backgroundColor: Color(0xff222222),
        child: Icon(Icons.add, color: Colors.white),
      ),
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
                  MaterialPageRoute(builder: (context) => AddMembersPage(forumTitle: forumTitle)),
                );
              } else if (value == 'settings') {
                // Navigate to Settings screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForumSettingsPage(forumId: forumId, forumTitle: forumTitle, forumDesc: '')),
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
      body: StreamBuilder<QuerySnapshot>(
        stream: postsCollection.where('forumId', isEqualTo: forumId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data?.docs.isEmpty ?? true) {
            return Center(child: Text('No posts available.'));
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              var post = snapshot.data!.docs[index].data()! as Map<String, dynamic>;

              return PostWidget(
                forumId: post['forumId'],
                postId: snapshot.data!.docs[index].id ?? 'defaultId',
                title: post['Title'],
                content: post['Content'],
                fname: post['fname'],
                lname: post['lname'],
                level: post['Level'],
                header: post['Header'],
                desc: post['Description'],
                profImgUrl: post['profImg'],
                time: post['time'],
              );
            },
          );
        },
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final String forumId;
  final String postId;
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

  PostWidget({
    required this.forumId,
    required this.postId,
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
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ForumPostDetail(title:title,
                content: content,
                fname: fname, lname: lname, level: level, header:
                header, desc: desc, profImgUrl:profImgUrl, time: time, forumId: forumId, forumTitle: title, postId: postId,

              ); // Pass the post to ForumPostDetail
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
            CircleAvatar(
              backgroundImage: NetworkImage(profImgUrl ?? ''),
              radius: 24,
            ),
            SizedBox(height: 16),

            Row(
              children: [
                Text(title ?? 'No Title', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(' • '),
                Text(fname + " " + lname ?? 'No Name', style: TextStyle(fontSize: 16)),
                Text(' • '),
                Text('${level ?? 'No Level'}', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 8),

            Text(time?.toDate().toString() ?? 'No Date', style: TextStyle(fontSize: 11, color: Color.fromRGBO(0, 0, 0, 1))),

            // Add this line to identify the property causing the issue
            Text('${header ?? 'No Header'}'),

            SizedBox(height: 8),
            Text('${header ?? 'No Header'}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 1))),
            SizedBox(height: 8),
            Text('${desc ?? 'No Description'}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Color.fromRGBO(0, 0, 0, 1))),

            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
