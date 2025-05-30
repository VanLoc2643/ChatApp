import 'package:appchat/model/AppUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final _firestore = FirebaseFirestore.instance;
  final _usersRef = FirebaseFirestore.instance.collection('users');

  Future<void> createOrUpdateUser(AppUser user) async {
    final docRef = _usersRef.doc(
      user.uid,
    ); //! nó chỉ trỏ đến địa chỉ thồi chưa troe đến dữ liệu cụ thể bằng get()
    final doc = await docRef.get(); //! Lấy dữ liệu user cụ thể

    if (!doc.exists) {
      await docRef.set(user.toMap());
    } else {
      await docRef.update({'lastSeen': FieldValue.serverTimestamp()});
    }
  }

  Future<AppUser?> getUserById(String uid) async {
    final doc = await _usersRef.doc(uid).get();
    if (doc.exists) {
      return AppUser.fromMap(doc.data()!);
    }
    return null;
  }

  Future<void> sendFriendRequest(
    String currentUserId,
    String targetUserId,
  ) async {
    await _usersRef.doc(targetUserId).update({
      'requests': FieldValue.arrayUnion([currentUserId]),
    });

    await _usersRef.doc(currentUserId).update({
      'sentRequests': FieldValue.arrayUnion([targetUserId]),
    });
  }

  Future<List<AppUser>> searchUsersByName(String query) async {
    final querySnapshot =
        await _usersRef
            .where('name', isGreaterThanOrEqualTo: query)
            .where('name', isLessThanOrEqualTo: query + '\uf8ff')
            .get();

    return querySnapshot.docs
        .map((doc) => AppUser.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> acceptFriendRequest(
    String currentUserId,
    String requestUid,
  ) async {
    await _usersRef.doc(currentUserId).update({
      'friends': FieldValue.arrayUnion([requestUid]),
      'requests': FieldValue.arrayRemove([requestUid]),
    });
    await _usersRef.doc(requestUid).update({
      'friends': FieldValue.arrayUnion([currentUserId]),
      'sentRequests': FieldValue.arrayRemove([currentUserId]),
    });
  }

  Future<List<AppUser>> getFriends(List<String> friendIds) async {
    List<AppUser> friends = [];
    for (String id in friendIds) {
      final snapshot = await _usersRef.doc(id).get();
      if (snapshot.exists) {
        friends.add(AppUser.fromMap(snapshot.data() as Map<String, dynamic>));
      }
    }
    return friends;
  }

  Future<List<AppUser>> getUsersByIds(List<String> userIds) async {
    final users = await Future.wait(userIds.map((id) => getUserById(id)));
    return users.whereType<AppUser>().toList();
  }

  Future<void> removeFriend(String friendId) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    final batch = _firestore.batch();

    final currentUserRef = _firestore.collection('users').doc(currentUser.uid);
    batch.update(currentUserRef, {
      'friends': FieldValue.arrayRemove([friendId]),
    });

    // Remove current user from friend's friends list
    final friendRef = _firestore.collection('users').doc(friendId);
    batch.update(friendRef, {
      'friends': FieldValue.arrayRemove([currentUser.uid]),
    });

    await batch.commit();
  }
}
