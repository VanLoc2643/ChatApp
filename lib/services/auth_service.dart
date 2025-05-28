import 'package:appchat/model/AppUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<AppUser?> signInWithGoogle() async {
    try {
      await _googleSignIn
          .signOut(); // Bắt buộc để show hộp thoại chọn tài khoản
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // User hủy đăng nhập

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
        // Nếu user chưa có document, tạo mới
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
        // Nếu đã tồn tại, trả về user hiện có
        return AppUser.fromMap(userDoc.data()!);
      }
    } catch (e) {
      print('Lỗi đăng nhập: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}
