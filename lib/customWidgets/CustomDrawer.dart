import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                  "Wasswa Maurice",
                   ),
              accountEmail: Text(
                  "mauricewassswa@gmail.com",
                  ),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                    child: Image.asset(
                      'assets/get_photo.jpeg',
                      fit: BoxFit.cover,
                      width: 90,
                      height: 90,
                    )
                ),
              ),
              decoration: BoxDecoration(
                  color: Color(0xff76ca71),
                  image: DecorationImage(
                    image: NetworkImage('https://media.istockphoto.com/id/1317007945/photo/exterior-view-of-a-typical-american-school-building.jpg?s=2048x2048&w=is&k=20&c=EtP-qsBPSSsWWMPfiewd9s5vGXk_ZGFbUvrV2fKPnVU='),
                    fit: BoxFit.fill,
                  )
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Class"),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text("Faculty"),
              onTap: () => null,
            ),

            ListTile(
              leading: Icon(Icons.school),
              title: Text("MUST"),
              onTap: () => null,
            ),
            const Divider(
              height: 10,
              color: Color(0xff76ca71),
              indent: 20,
              endIndent: 30,
              thickness: 2,
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text("Notices"),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.people_alt),
              title: Text("Staff"),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.person_2_rounded),
              title: Text("Contacts"),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.new_releases),
              title: Text("Latest"),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.dangerous),
              title: Text("Help"),
              onTap: () => null,
            ),
            const Divider(
              height: 10,
              color: Color(0xff76ca71),
              indent: 20,
              endIndent: 30,
              thickness: 2,
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () => null,
            ),
          ],
        )
    );
  }
}
