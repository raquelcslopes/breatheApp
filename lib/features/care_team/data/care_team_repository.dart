import 'package:breathe/features/care_team/data/care_team_contact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CareTeamRepository {
  final FirebaseFirestore _db;

  CareTeamRepository({FirebaseFirestore? firestore})
    : _db = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _careTeam(String uid) =>
      _db.collection('users').doc(uid).collection('careTeam');

  Future<void> _clearTrustedExcept(
    String uid,
    String? keepId,
    WriteBatch batch,
  ) async {
    final snap = await _careTeam(
      uid,
    ).where('isTrustedPerson', isEqualTo: true).get();

    for (final doc in snap.docs) {
      if (doc.id != keepId) {
        batch.update(doc.reference, {'isTrustedPerson': false});
      }
    }
  }

  Future<void> saveContact(String uid, CareTeamContact contact) async {
    final ref = _careTeam(uid).doc();
    final batch = _db.batch();

    if (contact.isTrustedPerson == true) {
      await _clearTrustedExcept(uid, null, batch);
    }

    batch.set(ref, contact.toMap());

    try {
      await batch.commit();
    } catch (e) {
      throw Exception("Failed to save contact: $e");
    }
  }

  Future<void> editContact(
    String uid,
    String contactId,
    CareTeamContact newContact,
  ) async {
    final batch = _db.batch();

    if (newContact.isTrustedPerson == true) {
      await _clearTrustedExcept(uid, contactId, batch);
    }

    batch.update(_careTeam(uid).doc(contactId), newContact.toMap());
    await batch.commit();
  }

  Future<void> deleteContact(String uid, String contactId) async {
    await _careTeam(uid).doc(contactId).delete();
  }

  Stream<List<CareTeamContact>> watchContacts(String uid) {
    return _careTeam(uid)
        .orderBy('name', descending: true)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((d) => CareTeamContact.fromMap(d.id, d.data()))
              .toList(),
        );
  }

  Stream<CareTeamContact?> watchTrustedContact(String uid) {
    return _careTeam(uid)
        .where('isTrustedPerson', isEqualTo: true)
        .limit(1)
        .snapshots()
        .map(
          (snap) => snap.docs.isEmpty
              ? null
              : CareTeamContact.fromMap(
                  snap.docs.first.id,
                  snap.docs.first.data(),
                ),
        );
  }
}
