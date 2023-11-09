import 'package:flutter/material.dart';

import '../side_menu/Nav_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
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
