import 'package:flutter/material.dart';
import '../side_menu/Nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(11),
              ),
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
          ),
          // Add a scrollable list of news feed items below the search
          Expanded(
            child: ListView.builder(
              itemCount: 30, // Replace with the number of items you have
              itemBuilder: (context, index) {
                // Replace this with the content for each news feed item
                return Column(
                  children: [
                    ListTile(
                      title: Text("Notice $index"),
                      subtitle: Text("This is the Description of Notice $index"),
                    ),
                    Container(
                      height: 200,
                      color: Colors.grey,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
