import 'package:flutter/material.dart';

import '../side_menu/Nav_bar.dart';

class NoticesPage extends StatelessWidget {
  const NoticesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        backgroundColor: Color(0xff76ca71),
        title: Text("My Notices",
            style: TextStyle(
              color: Colors.white,
              // Set the text color of the title
            )),
        centerTitle: true,
      ),

      body: Container(
        child: Center(
          child: Text(
              "You Don't have any Notices Yet"
          ),
        ),
      ),

    );
  }
}