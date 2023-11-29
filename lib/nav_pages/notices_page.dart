import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../customWidgets/add_forum.dart';
import '../customWidgets/forum_widget.dart';
import '../firebase/firebase_user_details.dart';
import '../side_menu/Nav_bar.dart';

class Forum {
  final String id;
  final String title;
  final String description;
  final int notificationCount;

  Forum({
    required this.id,
    required this.title,
    required this.description,
    required this.notificationCount,
  });
}

String forum_id = '';

class NoticesPage extends StatefulWidget {
   NoticesPage({Key? key}) : super(key: key);



  @override
  _NoticesPageState createState() => _NoticesPageState();
}

class _NoticesPageState extends State<NoticesPage> {
  Map<String, dynamic>? userDetails;
  List<Forum> enrolledForums = [];

  @override
  void initState() {
    super.initState();
    _getUserDetails();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      print('Auth State Change: $user');
      _getUserDetails();
      if (user != null) {
        _fetchEnrolledForums(user.uid);
      } else {
        setState(() {
          enrolledForums = [];
        });
      }
    });
  }

  void _getUserDetails() async {
    userDetails = await getUserDetails();
    print('User Details: $userDetails');
    if (userDetails != null) {
      setState(() {});
    }
  }

  void _fetchEnrolledForums(String userId) async {
    try {
      QuerySnapshot membershipSnapshot = await FirebaseFirestore.instance
          .collection('forums')
          .where('members', arrayContains: userId)
          .get();

      print('Membership Snapshot: $membershipSnapshot');

      List<Forum> forums = [];

      for (QueryDocumentSnapshot doc in membershipSnapshot.docs) {
        print('Forum Member Document ID: ${doc.id}');
        DocumentSnapshot forumSnapshot = await FirebaseFirestore.instance
            .collection('forums')
            .doc(doc.id)
            .get();

        forum_id = doc.id;


        if (forumSnapshot.exists) {
          print('Forum Data: ${forumSnapshot.data()}');

          try {
            Forum forum = Forum(
              id: forumSnapshot.id,
              title: forumSnapshot['title'] ?? 'Default Title',
              description: forumSnapshot['description'] ?? 'Default Description', notificationCount: 0,
              // Add other fields as needed
            );

            forums.add(forum);
          } catch (e) {
            print('Error creating Forum object: $e');
          }
        }
      }


      print('Enrolled Forums: $forums');

      setState(() {
        enrolledForums = forums;
      });
    } catch (e) {
      print('Error fetching enrolled forums: $e');
      setState(() {
        enrolledForums = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return AddForum();
              },
            ),
          );
        },
        backgroundColor: Color(0xff222222),
        child: Icon(Icons.add, color: Colors.white),
      ),
      drawer: Navbar(
        context: context,
        fName: userDetails != null ? userDetails!['lname'] : '',
        lName: userDetails != null ? userDetails!['email'] : '',
        userEmail: userDetails != null ? userDetails!['fname'] : '',
        profImgUrl: userDetails != null ? userDetails!['profImg'] : '',
      ),
      appBar: AppBar(
        backgroundColor: Color(0xff76ca71),
        title: Text(
          "Forums",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: enrolledForums.isEmpty
          ? Center(
        child: Text("You are not enrolled in any forums"),
      )
          : ListView.builder(
        itemCount: enrolledForums.length,
        itemBuilder: (context, index) {
          final forum = enrolledForums[index];
          return ForumWidget(

            title: forum.title,
            description: forum.description,
            notificationCount: forum.notificationCount,
          );
        },
      ),

    );
  }
}
