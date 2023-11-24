import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../customWidgets/add_forum.dart';
import '../customWidgets/forum_widget.dart';
import '../firebase/firebase_user_details.dart';
import '../side_menu/Nav_bar.dart';

class Forum {
  final String title;
  final String description;
  final int notificationCount;

  Forum({
    required this.title,
    required this.description,
    required this.notificationCount,
  });
}

class NoticesPage extends StatefulWidget {
  const NoticesPage({Key? key}) : super(key: key);

  @override
  _NoticesPageState createState() => _NoticesPageState();
}

class _NoticesPageState extends State<NoticesPage> {
  Map<String, dynamic>? userDetails;

  // Sample list of enrolled forums (replace it with your data)
  List<Forum> enrolledForums = [
    Forum(title: 'Forum 1', description: 'Description of Forum 1', notificationCount: 3),
    Forum(title: 'Forum 2', description: 'Description of Forum 2', notificationCount: 0),
    // Add more forums as needed
  ];

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
