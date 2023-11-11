import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../firebase/firebase_user_details.dart';
import '../side_menu/Nav_bar.dart';

class NoticesPage extends StatefulWidget {
  const NoticesPage({Key? key}) : super(key: key);

  @override
  _NoticesPageState createState() => _NoticesPageState();
}

class _NoticesPageState extends State<NoticesPage> {
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

      setState(() {}); // Trigger a rebuild when userDetails is updated
    } else {
      print('User details not available.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(
        context: context,
        fName: userDetails != null ? userDetails!['lname'] : '',
        lName: userDetails != null ? userDetails!['email'] : '',
        userEmail: userDetails != null ? userDetails!['fname'] : '',
        profImgUrl: userDetails != null ? userDetails!['profImg'] :'',
      ),
      appBar: AppBar(
        backgroundColor: Color(0xff76ca71),
        title: Text(
          "My Notices",
          style: TextStyle(
            color: Colors.white,
            // Set the text color of the title
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Text("You don't have any notices yet"),
        ),
      ),
    );
  }
}
