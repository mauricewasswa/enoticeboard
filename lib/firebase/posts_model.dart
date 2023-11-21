// post_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String title;
  final String content;
  final String fname;
  final String lname;
  final String level;
  final String header;
  final String desc;
  final String profImgUrl;
  final Timestamp time;
  final postdoc;

  Post({
    required this.title,
    required this.content,
    required this.fname,
    required this.lname,
    required this.level,
    required this.header,
    required this.desc,
    required this.profImgUrl,
    required this.time,
    this.postdoc,
  });
}
