import 'package:flutter/material.dart';

class NewsDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff76ca71),
        title: Text('Notice Detail'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                offset: Offset(5, 7),
                blurRadius: 15,
              ),
            ],
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture
              CircleAvatar(
                backgroundColor: Color(0xff76ca71),
                backgroundImage: AssetImage('assets/get_photo.jpeg'),
                radius: 24,
              ),
              SizedBox(height: 16),

              // Title, Name, and Level
              Row(
                children: [
                  Text('Title', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(' • '),
                  Text('Name', style: TextStyle(fontSize: 16)),
                  Text(' • '),
                  Text('Level', style: TextStyle(fontSize: 16)),
                ],
              ),
              SizedBox(height: 8),

              // Date and Time
              Text('21-11-2023 • 09:23 AM', style: TextStyle(fontSize: 11, color: Color.fromRGBO(0, 0, 0, 1))),

              SizedBox(height: 16),

              // Body of the Notice (dummy text)
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin congue neque aliquet hendrerit. Aliquam enim quam, sodales eget urna sed, bibendum rutrum risus. Mauris eu convallis tortor. Integer ut lacinia odio. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin congue neque aliquet hendrerit. Aliquam enim quam, sodales eget urna sed, bibendum rutrum risus. Mauris eu convallis tortor. Integer ut lacinia odio. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',
                style: TextStyle(fontSize: 12, color: Color.fromRGBO(0, 0, 0, 1)),
              ),

              SizedBox(height: 16),

              // Document Icon (PDF icon)
              Row(
                children: [
                  Icon(
                    Icons.picture_as_pdf, // PDF icon
                    size: 24,
                    color: Color(0xff222222),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Document.pdf', // Replace with the actual document name
                    style: TextStyle(fontSize: 14, color: Color(0xff222222)),
                  ),
                ],
              ),

              Row(
                children: [
                  Icon(
                    Icons.picture_as_pdf, // PDF icon
                    size: 24,
                    color: Color(0xff222222),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Document.pdf', // Replace with the actual document name
                    style: TextStyle(fontSize: 14, color: Color(0xff222222)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
