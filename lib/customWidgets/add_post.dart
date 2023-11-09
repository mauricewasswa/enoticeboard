import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AddNotice extends StatefulWidget {
  AddNotice({Key? key}) : super(key: key);

  @override
  _AddNoticeState createState() => _AddNoticeState();
}

class _AddNoticeState extends State<AddNotice> {
  String? selectedFileName; // To store the selected file name

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
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16.0),

            // Description Field
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16.0),

            // Content Field
            TextFormField(
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
