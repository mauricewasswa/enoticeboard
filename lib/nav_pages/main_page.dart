import 'package:enoticeboard/nav_pages/home_page.dart';
import 'package:enoticeboard/nav_pages/notices_page.dart';
import 'package:enoticeboard/nav_pages/profile_page.dart';
import 'package:enoticeboard/nav_pages/settings_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
List pages =[
  MainPage(),
  NoticesPage(),
  ProfilePage(),
  SettingsPage()
];
int currentIndex = 0;
void onTap(int index) {
  setState(() {
    currentIndex = index;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 0,
        selectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.withOpacity(0.7),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: [
          BottomNavigationBarItem(label:( "Home"),icon: Icon(Icons.apps)),
          BottomNavigationBarItem(label:( "Notices"),icon: Icon(Icons.list)),
          BottomNavigationBarItem(label:( "Profile"),icon: Icon(Icons.person)),
          BottomNavigationBarItem(label:( "Settings"),icon: Icon(Icons.settings)),
        ],
      ),
    );
  }
}