import 'package:breathe/features/emergency/data/emergency_contact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmergencyRepository {
  final FirebaseFirestore _db;

  EmergencyRepository({FirebaseFirestore? firestore})
    : _db = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _emergencyContacts() =>
      _db.collection('emergencyNumbers');

  Stream<List<EmergencyContact>> watchContacts() {
    return _emergencyContacts()
        .orderBy('name', descending: true)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((d) => EmergencyContact.fromMap(d.id, d.data()))
              .toList(),
        );
  }
}
