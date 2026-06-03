import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_profile.dart';

class ProfileRepository {
  ProfileRepository({FirebaseFirestore? firestore})
    : _db = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  DocumentReference<Map<String, dynamic>> _userDoc(String uid) =>
      _db.collection('users').doc(uid);

  Future<UserProfile?> fetchProfile(String uid) async {
    print('>>> FETCH uid: $uid');
    final snapshot = await _userDoc(uid).get();
    print('>>> FETCH existe? ${snapshot.exists} | dados: ${snapshot.data()}');
    if (!snapshot.exists) return null;
    return UserProfile.fromMap(uid, snapshot.data()!);
  }

  Future<void> saveProfile(UserProfile profile) async {
    await _userDoc(profile.uid).set(profile.toMap(), SetOptions(merge: true));
  }

  Future<void> markOnboardingComplete(String uid) async {
    await _userDoc(
      uid,
    ).set({'onboardingComplete': true}, SetOptions(merge: true));
  }
}
