import 'package:breathe/features/journal/data/journal_entry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JournalRepository {
  final FirebaseFirestore _db;

  JournalRepository({FirebaseFirestore? firestore})
    : _db = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _entries(String uid) =>
      _db.collection('users').doc(uid).collection('entries');

  Future<void> saveJounalEnrtry(String id, JournalEntry entry) async {
    final ref = _entries(id).doc();

    await ref.set(entry.toMap());
  }

  Future<List<JournalEntry>> fetchEntries(String id) async {
    final response = await _entries(
      id,
    ).orderBy('createdAt', descending: true).get();
    return response.docs
        .map((d) => JournalEntry.fromMap(d.id, d.data()))
        .toList();
  }

  Stream<List<JournalEntry>> watchEntries(String uid) {
    return _entries(uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((d) => JournalEntry.fromMap(d.id, d.data()))
              .toList(),
        );
  }

  Future<JournalEntry?> fetchEntry(String uid, String entryId) async {
    final doc = await _entries(uid).doc(entryId).get();

    if (!doc.exists) return null;
    return JournalEntry.fromMap(doc.id, doc.data()!);
  }
}
