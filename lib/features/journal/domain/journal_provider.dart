import 'package:breathe/features/journal/data/journal_entry.dart';
import 'package:breathe/features/journal/data/journal_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final journalRepositoryProvider = Provider<JournalRepository>((ref) {
  return JournalRepository();
});

final entriesProvider = StreamProvider.autoDispose<List<JournalEntry>>((ref) {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return Stream.value([]);
  return ref.watch(journalRepositoryProvider).watchEntries(uid);
});

final entryProvider = FutureProvider.family.autoDispose<JournalEntry?, String>((
  ref,
  id,
) {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return null;
  return ref.watch(journalRepositoryProvider).fetchEntry(uid, id);
});
