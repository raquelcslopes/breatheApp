import 'package:breathe/features/care_team/data/care_team_contact.dart';
import 'package:breathe/features/care_team/data/care_team_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final careTeamProvider = Provider<CareTeamRepository>((ref) {
  return CareTeamRepository();
});

final contactsProvider = StreamProvider.autoDispose<List<CareTeamContact>>((
  ref,
) {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return Stream.value([]);
  return ref.watch(careTeamProvider).watchContacts(uid);
});

final trustedPersonsProvider =
    StreamProvider.autoDispose<List<CareTeamContact>>((ref) {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return Stream.value([]);
      return ref.watch(careTeamProvider).watchTrustedContacts(uid);
    });
