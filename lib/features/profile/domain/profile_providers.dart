import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/profile_repository.dart';
import '../data/user_profile.dart';

final currentUidProvider = StreamProvider<String?>((ref) {
  return FirebaseAuth.instance.authStateChanges().map((user) => user?.uid);
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository();
});

final userProfileProvider = FutureProvider<UserProfile?>((ref) async {
  final uid = ref.watch(currentUidProvider).value;
  if (uid == null) return null;

  final repository = ref.watch(profileRepositoryProvider);
  return repository.fetchProfile(uid);
});
