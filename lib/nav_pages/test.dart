// test_page.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../customWidgets/add_post.dart';
import '../customWidgets/customAppBar.dart';
import '../customWidgets/news_feed.dart';
import '../firebase/firebase_service.dart';
import '../firebase/firebase_user_details.dart';
import '../firebase/posts_model.dart';
import '../customWidgets/CustomDrawer.dart'; // Import your custom widgets

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  Map<String, dynamic>? userDetails;

  @override
  void initState() {
    super.initState();
    // Call getUserDetails when the widget is initialized
    _getUserDetails();

    // Listen for changes in authentication state
    FirebaseAuth.instance.authStateChanges().listen((user) {
      // When the authentication state changes, update user details
      _getUserDetails();
    });
  }

  void _getUserDetails() async {
    userDetails = await getUserDetails();
    if (userDetails != null) {
      // Use the user details as needed
      print('FName: ${userDetails!['fname']}');
      print('LName: ${userDetails!['lname']}');
      print('User Title: ${userDetails!['title']}');
      print('User Level: ${userDetails!['level']}');
      print('img url : ${userDetails!['profImg']}');

      setState(() {}); // Trigger a rebuild when userDetails is updated

    } else {
      print('User details not available.');
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
                return AddNotice();
              },
            ),
          );
        },
        backgroundColor: Color(0xff222222),
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 30),
            child: CustomAppBar(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 30,
                    child: Image.asset('assets/search.png'),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search Notices...",
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseService.getPostsStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                List<Post> posts = snapshot.data!.docs.map((doc) {
                  Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                  return Post(
                    title: data['Title'] ?? '',
                    content: data['Content'] ?? '',
                    fname: data['fname'] ?? '',
                    lname: data['lname']?? '',
                    level: data['Level']?? '',
                    header: data ['Header']?? '',
                    desc: data['Description'] ?? '',
                    profImgUrl: data['profImg'] ?? '',
                    // date: data['Date'] ?? '',
                  );
                }).toList();

                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return NewsFeedItem(post: posts[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
      drawer: userDetails != null
          ? CustomDrawer(
        context: context,
        userEmail: userDetails!['fname'],
        fName: userDetails!['lname'],
        lName: userDetails!['email'],
        profImgurl: userDetails!['profImg'],
      )
          : CircularProgressIndicator(), // Loading indicator while fetching userDetails
    );
  }
}
