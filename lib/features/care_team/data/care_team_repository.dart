import 'package:breathe/features/care_team/data/care_team_contact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CareTeamRepository {
  final FirebaseFirestore _db;

  CareTeamRepository({FirebaseFirestore? firestore})
    : _db = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _careTeam(String uid) =>
      _db.collection('users').doc(uid).collection('careTeam');

  Future<void> saveContact(String uid, CareTeamContact contact) async {
    final ref = _careTeam(uid).doc();

    try {
      await ref.set(contact.toMap());
    } catch (e) {
      throw Exception("Failed to save contact: $e");
    }
  }

  Future<void> deleteContact(String uid, String contactId) async {
    await _careTeam(uid).doc(contactId).delete();
  }

  Future<void> editContact(
    String uid,
    String contactId,
    CareTeamContact newContact,
  ) async {
    final contact = newContact.toMap();
    await _careTeam(uid).doc(contactId).update(contact);
  }

  Stream<List<CareTeamContact>> watchEntries(String uid) {
    return _careTeam(uid)
        .orderBy('name', descending: true)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((d) => CareTeamContact.fromMap(d.id, d.data()))
              .toList(),
        );
  }
}
