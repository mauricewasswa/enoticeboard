import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enoticeboard/customWidgets/btn_widget.dart';
import 'package:enoticeboard/nav_pages/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  Future<void> _signInWithEmailAndPassword() async {
    try {
      setState(() {
        _isLoading = true; // Show progress indicator
      });

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Getting user's email
      await getUserDetails(userCredential.user?.email);

      // User signed in successfully, navigate to the next screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid credentials. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error signing in: $e');
    } finally {
      setState(() {
        _isLoading = false; // Hide progress indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.only(top: 30, left: 50, right: 50, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Image.asset(
                  'assets/logo.png',
                  height: 200,
                  width: 200,
                ),
              ),
              Text(
                "Welcome!",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              _isLoading
                  ? CircularProgressIndicator() // Show progress indicator if loading
                  : BtnWidget(
                onTap: _signInWithEmailAndPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getUserDetails(String? userEmail) async {
    if (userEmail != null) {
      try {
        // Access the "users" collection
        CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

        // Query the "users" collection using the user's email
        QuerySnapshot querySnapshot = await usersCollection.where('email', isEqualTo: userEmail).get();

        if (querySnapshot.docs.isNotEmpty) {
          // Access the user's details from the first document (assuming unique emails)
          DocumentSnapshot userSnapshot = querySnapshot.docs.first;

          String fname = userSnapshot['fname'];
          String lname = userSnapshot['lname'];
          String userLevel = userSnapshot['level'];
          String userTitle = userSnapshot['title'];

          // Now you have access to the additional details about the user
          print('User FName: $fname');
          print('User LName: $lname');
          print('User Level: $userLevel');
          print('User Title: $userTitle');
        } else {
          print('User document does not exist in the "users" collection.');
        }
      } catch (e) {
        print('Error getting user details: $e');
        // Handle errors when retrieving user details
      }
    } else {
      print('User email is null.');
    }
  }
}
