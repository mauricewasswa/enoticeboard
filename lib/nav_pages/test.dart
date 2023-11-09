import 'package:flutter/material.dart';

import '../customWidgets/CustomDrawer.dart';
import '../customWidgets/add_post.dart';
import '../customWidgets/customAppBar.dart';
import '../customWidgets/news_details.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return AddNotice();
              },
            ),
          );
        },
        backgroundColor: Color(0xff222222),
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 30),
              child: CustomAppBar()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 5.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 30,
                    child: Image.asset('assets/search.png'),

                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search Notices...",
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),// Use your custom app bar here
          Expanded(
            child: ListView(
              children: [
                NewsFeedItem(),
                NewsFeedItem(),
                NewsFeedItem(),
                NewsFeedItem(),
                NewsFeedItem(),
                NewsFeedItem(),
              ],
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(), // Add your custom drawer widget if needed
    );
  }
}

class NewsFeedItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return NewsDetailPage();
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.all(16),
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
                Text('AR', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(' • '),
                Text('Wasswa Maurice', style: TextStyle(fontSize: 16)),
                Text(' • '),
                Text('ADMIN', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 8),

            // Date and Time
            Text('21-11-2023 • 09:23 AM', style: TextStyle(fontSize: 11, color: Color.fromRGBO(0, 0, 0, 1))),

            SizedBox(height: 8),
            Text('Change Of Programme update.', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 1))),

            SizedBox(height: 16),

            // Body of the Notice (dummy text)
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin congue neque aliquet hendrerit. Aliquam enim quam, sodales eget urna sed, bibendum rutrum risus. Mauris eu convallis tortor. Integer ut lacinia odio. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',
              style: TextStyle(fontSize: 12, color: Color.fromRGBO(0, 0, 0, 1)),
            ),
          ],
        ),
      ),
    );
  }
}
