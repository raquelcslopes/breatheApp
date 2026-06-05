import 'package:breathe/features/journal/data/journal_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final journalRepositoryProvider = Provider<JournalRepository>((ref) {
  return JournalRepository();
});
