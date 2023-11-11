// firebase_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Stream<QuerySnapshot> getPostsStream() {
    return _firestore.collection('posts').snapshots();
  }
}
