import 'package:appchat/model/AppUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<AppUser?> signInWithGoogle() async {
    try {
      await _googleSignIn.signOut();
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user == null) return null;

      final userDocRef = _firestore.collection('users').doc(user.uid);
      final userDoc = await userDocRef.get();
      if (!userDoc.exists) {
        final newUser = AppUser(
          uid: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
          photoUrl: user.photoURL ?? '',
          lastSeen: DateTime.now(),
        );
        await userDocRef.set(newUser.toMap());
        return newUser;
      } else {
        return AppUser.fromMap(userDoc.data()!);
      }
    } catch (e) {
      print('Lỗi đăng nhập: $e');
      return null;
    }
  }

  Future<AppUser?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status != LoginStatus.success) {
        return null;
      }

      final AccessToken? accessToken = result.accessToken;
      if (accessToken == null) return null;

      final OAuthCredential credential = FacebookAuthProvider.credential(
        accessToken.tokenString,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user == null) return null;

      final userData = await FacebookAuth.instance.getUserData();

      final userDocRef = _firestore.collection('users').doc(user.uid);
      final userDoc = await userDocRef.get();

      if (!userDoc.exists) {
        final newUser = AppUser(
          uid: user.uid,
          name: userData['name'] ?? '',
          email: userData['email'] ?? '',
          photoUrl: userData['picture']['data']['url'] ?? '',
          lastSeen: DateTime.now(),
        );
        await userDocRef.set(newUser.toMap());
        return newUser;
      } else {
        return AppUser.fromMap(userDoc.data()!);
      }
    } catch (e) {
      print('Facebook login error: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}
