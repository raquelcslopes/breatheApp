import 'package:cloud_firestore/cloud_firestore.dart';

class JournalEntry {
  final String id;
  final List<String> problemKeys;
  final String? moodKey;
  final String text;
  final DateTime createdAt;

  const JournalEntry({
    required this.id,
    this.problemKeys = const [],
    this.moodKey,
    required this.text,
    required this.createdAt,
  });

  factory JournalEntry.fromMap(String id, Map<String, dynamic> map) {
    return JournalEntry(
      id: id,
      problemKeys: List<String>.from(map['problemKeys'] ?? const []),
      moodKey: map['moodKey'] as String?,
      text: map['text'] as String? ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'problemKeys': problemKeys,
      'moodKey': moodKey,
      'text': text,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  JournalEntry copyWith({
    String? id,
    List<String>? problemKeys,
    String? moodKey,
    String? text,
    DateTime? createdAt,
  }) {
    return JournalEntry(
      id: id ?? this.id,
      problemKeys: problemKeys ?? this.problemKeys,
      moodKey: moodKey ?? this.moodKey,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
