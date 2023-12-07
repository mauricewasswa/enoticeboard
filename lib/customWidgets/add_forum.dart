import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../firebase/firebase_user_details.dart';

// Import other necessary files

class AddForum extends StatefulWidget {
  AddForum({Key? key}) : super(key: key);

  @override
  State<AddForum> createState() => _AddForumState();
}

class _AddForumState extends State<AddForum> {
  Map<String, dynamic>? userDetails;

  // Text editing controllers for input fields
  TextEditingController forumNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
      appBar: AppBar(
        backgroundColor: Color(0xff76ca71),
        title: Text(
          "Create New Forum",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Forum Name Input
            TextField(
              controller: forumNameController,
              decoration: InputDecoration(labelText: 'Forum Name'),
            ),
            SizedBox(height: 16.0),

            // Description Input
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16.0),

            // Forum Image Selection (You can use plugins like image_picker)
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xff222222)),
              ),
              onPressed: () {
                // TODO: Implement image selection logic
              },
              child: Text('Select Forum Image'),
            ),
            SizedBox(height: 16.0),

            // Search Area to Add Members
            // TODO: Implement search area for adding members

            // Button to Submit Forum Details
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xff222222)),
              ),
              onPressed: () async {
                // TODO: Implement logic to submit forum details
                // You can access input values using controller.text

                String forumName = forumNameController.text;
                String description = descriptionController.text;

                // Get the current user
                User? currentUser = FirebaseAuth.instance.currentUser;

                if (currentUser != null) {
                  // Add the forum to Firestore
                  DocumentReference forumRef = await FirebaseFirestore.instance.collection('forums').add({
                    'title': forumName,
                    'description': description,
                    // Add other fields as needed
                  });

                  // Get the forum ID
                  String forumId = forumRef.id;

                  // Enroll the first user as the admin and member
                  await FirebaseFirestore.instance.collection('forums').doc(forumId).set({
                    'title': forumName,
                    'description': description,
                    'admin': currentUser.uid,
                    'members': [currentUser.uid], // The first user is also a member
                  });
                  print(currentUser.uid);

                  // Optionally, you can navigate to a different screen or perform other actions after submitting
                  Navigator.pop(context);
                } else {
                  // Handle the case where the current user is null (should not happen if authentication is set up correctly)
                  print('Error: Current user is null');
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
