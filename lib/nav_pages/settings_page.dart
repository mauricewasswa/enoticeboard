import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../firebase/firebase_user_details.dart';
import '../side_menu/Nav_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

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
        title: Text("Settings",
            style: TextStyle(
              color: Colors.white,
              // Set the text color of the title
            )),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Account Settings"),
            subtitle: Text("Update your account information"),
            leading: Icon(Icons.account_circle),
            onTap: () {
              // Navigate to account settings page
              // You can use Navigator to navigate to a new page.
            },
          ),
          Divider(),
          ListTile(
            title: Text("Notifications"),
            subtitle: Text("Configure app notifications"),
            leading: Icon(Icons.notifications),
            onTap: () {
              // Navigate to notifications settings page
              // You can use Navigator to navigate to a new page.
            },
          ),
          Divider(),
          ListTile(
            title: Text("Privacy"),
            subtitle: Text("Manage your privacy settings"),
            leading: Icon(Icons.privacy_tip),
            onTap: () {
              // Navigate to privacy settings page
              // You can use Navigator to navigate to a new page.
            },
          ),
          Divider(),
          // Add more settings options as needed
        ],
      ),
    );
  }
}
