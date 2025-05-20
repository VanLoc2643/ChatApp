import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String email;
  final String uid;
  final String photoUrl;
  final DateTime? createdAt;

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
    this.createdAt, //
  });
  factory User.fromMap(Map<String, dynamic> user) {
    return User(
      uid: user['uid'],
      email: user['email'],
      name: user['name'],
      photoUrl: user['photoUrl'],
      createdAt:
          user['createdAt'] != null
              ? (user['createdAt'] as Timestamp).toDate()
              : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'createAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
    };
  }
}
