import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../onboarding/sign_in.dart';


class Navbar extends StatelessWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final BuildContext context;
  late final String fName;
  late final String lName;
  late final String userEmail;
  late final String profImgUrl;

  Navbar({
    Key? key,
    required this.context,
    required this.fName,
    required this.lName,
    required this.userEmail,
    required this.profImgUrl,
  }) : super(key: key);

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      // User signed out successfully
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false, // Pop all existing routes
      );
    } catch (e) {
      // Handle sign-out errors here, e.g., show an error message.
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              fName+ " " +userEmail,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,

              ),
            ),
            accountEmail: Text(
              lName,
              style: TextStyle(
                fontSize: 15,

              ),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  profImgUrl,
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xff76ca71),
              image: DecorationImage(
                image: NetworkImage(
                    'https://media.istockphoto.com/id/1317007945/photo/exterior-view-of-a-typical-american-school-building.jpg?s=2048x2048&w=is&k=20&c=EtP-qsBPSSsWWMPfiewd9s5vGXk_ZGFbUvrV2fKPnVU='),
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Class"),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text("Faculty"),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text("MUST"),
            onTap: () => null,
          ),
          const Divider(
            height: 10,
            color: Color(0xff76ca71),
            indent: 20,
            endIndent: 30,
            thickness: 2,
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text("Notices"),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.people_alt),
            title: Text("Staff"),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.person_2_rounded),
            title: Text("Contacts"),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.new_releases),
            title: Text("Latest"),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.dangerous),
            title: Text("Help"),
            onTap: () => null,
          ),
          const Divider(
            height: 10,
            color: Color(0xff76ca71),
            indent: 20,
            endIndent: 30,
            thickness: 2,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: _signOut,
          ),
        ],
      ),
    );
  }
}
