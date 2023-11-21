import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

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
  File? selectedFilePath;
  String? fileDownloadUrl; // To store the download URL of the uploaded file

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
                FilePickerResult? result = await FilePicker.platform.pickFiles();
                if (result != null && result.files.isNotEmpty) {
                  String fileName = result.files.single.name;
                  String filePath = result.files.single.path!;

                  setState(() {
                    selectedFileName = fileName;
                    selectedFilePath = File(filePath);
                  });
                } else {
                  print("No file selected");
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
                'Selected File: ${selectedFileName?.split('/').last}',  // Extracting the file name from the path
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
              onPressed: () async {
                if (selectedFileName != null) {
                  File file = selectedFilePath!;

                  // Ensure that the file exists before attempting to upload
                  if (file.existsSync()) {
                    // Create a reference to the Firebase Storage location
                    String uniqueFileName = "${DateTime.now().millisecondsSinceEpoch}_$selectedFileName";
                    firebase_storage.Reference storageReference =
                    firebase_storage.FirebaseStorage.instance.ref().child(uniqueFileName);

                    try {
                      // Upload the file to Firebase Storage
                      await storageReference.putFile(file);

                      // Get the download URL of the uploaded file
                      String downloadURL = await storageReference.getDownloadURL();

                      // Update the UI with the download URL
                      setState(() {
                        fileDownloadUrl = downloadURL;
                      });

                      print('File uploaded. Download URL: $downloadURL');
                    } catch (e) {
                      print('Error uploading file: $e');
                    }
                  } else {
                    print('File does not exist: $selectedFileName');
                  }
                }

                // Add your form submission logic here
                CollectionReference collRef = FirebaseFirestore.instance.collection('posts');
                collRef.add(
                  {
                    'Header': _headerController.text,
                    'Content': _contentController.text,
                    'Description': _descController.text,
                    'fname': userDetails!['fname'],
                    'lname': userDetails!['lname'],
                    'Title': userDetails!['title'],
                    'Level': userDetails!['level'],
                    'profImg': userDetails!['profImg'],
                    'time': FieldValue.serverTimestamp(),
                    'Doc': fileDownloadUrl,
                  },
                );

                Navigator.pop(context); // Implement form submission logic
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
