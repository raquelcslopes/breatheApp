import 'package:breathe/features/journal/data/journal_entry.dart';
import 'package:breathe/features/journal/domain/journal_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final watchEntriesProvider = StreamProvider.autoDispose<List<JournalEntry>>((
  ref,
) {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return Stream.value([]);

  final now = DateTime.now();
  final start = DateTime(
    now.year,
    now.month,
    now.day,
  ).subtract(const Duration(days: 6));
  return ref
      .watch(journalRepositoryProvider)
      .watchEntriesBetween(uid, start, now);
});
