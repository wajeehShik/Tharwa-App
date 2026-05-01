import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thrawa_app/models/user_model.dart';

/// Data layer: Firebase authentication and Firestore user profile.
/// No UI, no state – just data in and data out.
class AuthFirebaseService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthFirebaseService({FirebaseAuth? auth, FirebaseFirestore? firestore})
    : _auth = auth ?? FirebaseAuth.instance,
      _firestore = firestore ?? FirebaseFirestore.instance;

  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final fbUser = credential.user!;
    return UserModel(
      id: fbUser.uid,
      name: fbUser.displayName ?? '',
      email: fbUser.email ?? '',
      token: await fbUser.getIdToken(),
    );
  }

  Future<UserModel> registerWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    // 1. Create user in Firebase Auth
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final fbUser = credential.user!;

    // 2. Update display name in Auth
    await fbUser.updateDisplayName(name);

    // 3. Save additional data to Firestore
    await _firestore.collection('users').doc(fbUser.uid).set({
      'uid': fbUser.uid,
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return UserModel(
      id: fbUser.uid,
      name: name,
      email: fbUser.email ?? '',
      token: await fbUser.getIdToken(),
    );
  }

  Future<void> signOut() async => _auth.signOut();

  User? get currentUser => _auth.currentUser;
}
