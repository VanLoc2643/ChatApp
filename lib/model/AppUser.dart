import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String name;
  final String email;
  final String photoUrl;
  final List<String> friends;
  final List<String> requests;
  final List<String> sentRequests;
  final DateTime lastSeen;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
    this.friends = const [],
    this.requests = const [],
    this.sentRequests = const [],
    required this.lastSeen,
  });

  factory AppUser.fromMap(Map<String, dynamic> data) {
    return AppUser(
      uid: data['uid'] as String? ?? '',
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      photoUrl: data['photoUrl'] as String? ?? '',
      // Nếu trường không phải List, đặt là rỗng
      friends:
          data['friends'] is List ? List<String>.from(data['friends']) : [],
      requests:
          data['requests'] is List ? List<String>.from(data['requests']) : [],
      sentRequests:
          data['sentRequests'] is List
              ? List<String>.from(data['sentRequests'])
              : [],
      lastSeen: (data['lastSeen'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'friends': friends,
      'requests': requests,
      'sentRequests': sentRequests,
      'lastSeen': Timestamp.fromDate(lastSeen),
    };
  }
}
