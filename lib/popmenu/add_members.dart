import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../users/users_model.dart';

class AddMembersPage extends StatefulWidget {
  final String forumTitle;
  const AddMembersPage({Key? key, required this.forumTitle});

  @override
  State<AddMembersPage> createState() => _AddMembersPageState();
}

class _AddMembersPageState extends State<AddMembersPage> {
  List<User> allUsers = [];
  List<User> selectedUsers = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch users from Firestore when the widget is initialized
    fetchUsersFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff76ca71),
        title: Text('Add Members'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search button press
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input field for search
            TextField(
              onChanged: (query) {
                filterUsers(query);
              },
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    filterUsers('');
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // List of users
            Expanded(
              child: ListView.builder(
                itemCount: allUsers.length,
                itemBuilder: (context, index) {
                  final user = allUsers[index];
                  final isSelected = selectedUsers.contains(user);

                  return ListTile(
                    title: Text('${user.fname} ${user.lname}'),
                    subtitle: Text(user.title),
                    onTap: () {
                      // Handle user tap
                      toggleUserSelection(user);
                    },
                    tileColor: isSelected ? Colors.blue.withOpacity(0.2) : null,
                    // Customize the appearance as needed
                  );
                },
              ),
            ),

            // Button for adding selected users
            ElevatedButton(
              onPressed: () {
                // Handle adding selected users
                // For example, you can enroll them in the forum
                enrollSelectedUsers();
              },
              child: Text('Add Members'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchUsersFromFirestore() async {
    try {
      // Reference to the users collection in Firestore
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

      // Query for all users
      QuerySnapshot usersSnapshot = await usersCollection.get();

      // Extract user data from the snapshot
      List<User> users = usersSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return User(userId: data['userId'], fname: data['fname'], lname: data['lname'], title: data['title'], level: data['level']); // Adjust this based on your user data model
      }).toList();

      setState(() {
        allUsers = users;
      });
    } catch (error) {
      print('Error fetching users from Firestore: $error');
    }
  }

  void filterUsers(String query) {
    List<User> filteredUsers = allUsers
        .where((user) => user.fname.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      selectedUsers = [];
      allUsers = filteredUsers;
    });
  }

  void toggleUserSelection(User user) {
    setState(() {
      if (selectedUsers.contains(user)) {
        selectedUsers.remove(user);
      } else {
        selectedUsers.add(user);
      }
    });
  }

  Future<void> enrollSelectedUsers() async {
    // Implement the logic to enroll selected users in the forum
    // You can use the 'selectedUsers' list for the selected users
    print('Selected Users: ${selectedUsers.map((user) => '${user.fname} ${user.lname} (${user.userId}) ').join(', ')}');

    String? forumId = await getForumId(widget.forumTitle);
    if (forumId != null) {
      print('Forum ID: $forumId');

      await FirebaseFirestore.instance.collection('forums').doc(forumId).update({
        'members': FieldValue.arrayUnion(selectedUsers.map((user) => user.userId).toList()),
      });

      // Clear the selected users list
      setState(() {
        selectedUsers = [];
      });
    } else {
      print('Forum not found');
      // Handle the case where the forum is not found
    }
  }

  Future<String?> getForumId(String forumName) async {
    try {
      // Reference to the forums collection in Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('forums')
          .where('title', isEqualTo: forumName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there is at most one forum with the given name
        return querySnapshot.docs.first.id;
      } else {
        print('Forum not found');
        return null;
      }
    } catch (error) {
      print('Error getting forum ID: $error');
      return null;
    }
  }
}
