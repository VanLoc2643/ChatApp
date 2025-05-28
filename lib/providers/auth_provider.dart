import 'package:appchat/model/AppUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  AppUser? _appUser;
  AppUser? get appUser => _appUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> loadUser() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        _appUser = null;
        notifyListeners();
        return;
      }

      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        _appUser = AppUser.fromMap(doc.data()!);
        notifyListeners();
      }
    } catch (e) {
      print('Error loading user: $e');
      rethrow;
    }
  }

  void setUser(AppUser user) {
    _appUser = user;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _appUser = null;
    notifyListeners();
  }
}
