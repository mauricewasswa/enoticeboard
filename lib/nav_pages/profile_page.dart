import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../firebase/firebase_user_details.dart';
import '../side_menu/Nav_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

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

          title: Text("My Profile",
              style: TextStyle(
                color: Colors.white,
                // Set the text color of the title
              )),
          centerTitle: true,
        ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(85),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // User's profile picture
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(userDetails!['profImg']), // Replace with the user's profile image
              ),
              SizedBox(height: 20), // Add spacing

              // User's name
              Text(
                userDetails!['lname'] + " " +userDetails!['fname'], // Replace with the user's name
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10), // Add spacing

              // User's email or additional information
              Text(
                userDetails!['email'], // Replace with the user's email or additional info
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20), // Add spacing

              // Edit Profile button
              ElevatedButton(

                onPressed: () {
                  // Navigate to the edit profile page
                  // You can use Navigator to navigate to a new page.
                },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xff222222)), // Change the color here
                  ),
                child: Text("Edit Profile"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
