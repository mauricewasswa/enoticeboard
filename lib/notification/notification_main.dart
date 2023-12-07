import 'package:flutter/material.dart';

class NotificationMain extends StatelessWidget {
  const NotificationMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace this with your actual list of notifications
    List<Widget> notificationList = [
      Container(
        margin: EdgeInsets.only(top: 30,bottom: 2,left: 20,right: 20),
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              color: Colors.black, // You can change the color to your preference
              width: 2, // You can adjust the border width as needed
            ),
          ),
          child: NotificationItem(title: 'Notice From MUST', message: 'This is the first notification')),
      Container(
          margin: EdgeInsets.only(top: 20,bottom: 2,left: 20,right: 20),
          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              color: Colors.black, // You can change the color to your preference
              width: 2, // You can adjust the border width as needed
            ),
          ),
          child: NotificationItem(title: 'Notification 1', message: 'This is the first notification')),
      Container(
          margin: EdgeInsets.only(top: 20,bottom: 2,left: 20,right: 20),
          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              color: Colors.black, // You can change the color to your preference
              width: 2, // You can adjust the border width as needed
            ),
          ),
          child: NotificationItem(title: 'Notification 1', message: 'This is the first notification')),
      Container(
          margin: EdgeInsets.only(top: 20,bottom: 2,left: 20,right: 20),
          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              color: Colors.black, // You can change the color to your preference
              width: 2, // You can adjust the border width as needed
            ),
          ),
          child: NotificationItem(title: 'Notification 1', message: 'This is the first notification')),
      Container(
          margin: EdgeInsets.only(top: 20,bottom: 2,left: 20,right: 20),
          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              color: Colors.black, // You can change the color to your preference
              width: 2, // You can adjust the border width as needed
            ),
          ),
          child: NotificationItem(title: 'Notification 1', message: 'This is the first notification')),


    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff76ca71),
        title: Text('Notifications'),
      ),
      body: ListView(
        children: notificationList,
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String message;

  NotificationItem({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(message),
      // Add any other widgets or styling you need for each notification item
    );
  }
}
