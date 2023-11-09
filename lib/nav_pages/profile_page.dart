import 'package:flutter/material.dart';

import '../side_menu/Nav_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Navbar(),
        appBar: AppBar(
          backgroundColor: Color(0xff76ca71),

          title: Text("My Profile",
              style: TextStyle(
                color: Colors.white,
                // Set the text color of the title
              )),
          centerTitle: true,
        ),
      body: Container(
        margin: EdgeInsets.all(85),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // User's profile picture
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/get_photo.jpeg'), // Replace with the user's profile image
            ),
            SizedBox(height: 20), // Add spacing

            // User's name
            Text(
              "Wasswa Maurice", // Replace with the user's name
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10), // Add spacing

            // User's email or additional information
            Text(
              "mauricewassswa@gmail.com", // Replace with the user's email or additional info
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
    );
  }
}
