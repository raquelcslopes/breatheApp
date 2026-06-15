import 'package:breathe/features/emergency/data/emergency_contact.dart';
import 'package:breathe/features/emergency/data/emergency_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emergencyProvider = Provider<EmergencyRepository>((ref) {
  return EmergencyRepository();
});

final emergencyContactsProvider =
    StreamProvider.autoDispose<List<EmergencyContact>>((ref) {
      return ref.watch(emergencyProvider).watchContacts();
    });
