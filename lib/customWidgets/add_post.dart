import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../firebase/firebase_user_details.dart';

class AddNotice extends StatefulWidget {
  AddNotice({Key? key}) : super(key: key);



  @override
  _AddNoticeState createState() => _AddNoticeState();
}

class _AddNoticeState extends State<AddNotice> {
  final _headerController = TextEditingController();
  final _descController = TextEditingController();
  final _contentController = TextEditingController();

  String? selectedFileName; // To store the selected file name

  Map<String, dynamic>? userDetails;

  @override
  void initState() {
    super.initState();
    // Call getUserDetails when the widget is initialized
    _getUserDetails();
  }


  // Function to get user details
  void _getUserDetails() async {
    userDetails = await getUserDetails();
    if (userDetails != null) {
      // Use the user details as needed
      print('FName: ${userDetails!['fname']}');
      print('LName: ${userDetails!['lname']}');
      print('User Title: ${userDetails!['title']}');
      print('User Level: ${userDetails!['level']}');
    } else {
      print('User details not available.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff76ca71),
        title: Text("Add Notice", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Field
            TextFormField(
              controller: _headerController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16.0),

            // Description Field
            TextFormField(
              controller: _descController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16.0),

            // Content Field
            TextFormField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: 4, // Allow multiple lines for content
            ),
            SizedBox(height: 16.0),

            // File Upload
            ElevatedButton(
              onPressed: () async {
                // Implement file upload logic
                FilePickerResult? result = await FilePicker.platform.pickFiles();
                if (result == null) {
                  print("No file selected");
                } else {
                  setState(() {
                    selectedFileName = result.files.single.name; // Store the selected file name
                    print(selectedFileName);
                  });
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xff222222)),
              ),
              child: Text('Attach File'),
            ),
            SizedBox(height: 8.0),

            // Display the selected file name
            if (selectedFileName != null)
              Text(
                'Selected File: $selectedFileName',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

            SizedBox(height: 16.0),

            // Expiry Date Picker
            ElevatedButton(
              onPressed: () {
                // Implement date picker logic
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xff222222)),
              ),
              child: Text('Select Expiry Date'),
            ),
            SizedBox(height: 16.0),

            // Submit Button
            ElevatedButton(
              onPressed: () {
                CollectionReference collRef = FirebaseFirestore.instance.collection('posts');
                collRef.add(
                  {
                    'Header' : _headerController.text,
                    'Content' : _contentController.text,
                    'Description' : _descController.text,
                    'fname' : userDetails!['fname'],
                    'lname' : userDetails!['lname'],
                    'Title' : userDetails!['title'],
                    'Level' : userDetails!['level'],
                    'profImg' : userDetails!['profImg'],
                    'Doc' : null

                  },
                );

                // Navigator.pop(context);
                // Implement form submission logic
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xff222222)),
              ),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
