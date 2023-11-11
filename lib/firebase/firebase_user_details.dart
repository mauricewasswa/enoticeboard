import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<Map<String, dynamic>?> getUserDetails() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    String userEmail = user.email!;

    try {
      // Reference to the users collection in Firestore
      CollectionReference users = FirebaseFirestore.instance.collection('users');

      // Query for the user with the matching email
      QuerySnapshot userSnapshot = await users.where('email', isEqualTo: userEmail).get();

      // Check if the user was found
      if (userSnapshot.docs.isNotEmpty) {
        // Extract user details from the first document in the result
        Map<String, dynamic> userDetails = userSnapshot.docs.first.data() as Map<String, dynamic>;
        return userDetails;
      } else {
        print('User details not found in Firestore for email: $userEmail');
        return null;
      }
    } catch (e) {
      print('Error fetching user details: $e');
      return null;
    }
  } else {
    print('No user is currently signed in.');
    return null;
  }
}
