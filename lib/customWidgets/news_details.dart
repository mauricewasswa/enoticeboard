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
        child: Text('Details of the notice feed item go here'),
      ),
    );
  }
}
