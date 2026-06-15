class EmergencyContact {
  final String id;
  final String name;
  final String description;
  final String phoneNumber;
  final int? startHour;
  final int? endHour;

  const EmergencyContact({
    required this.id,
    required this.name,
    required this.description,
    required this.phoneNumber,
    this.startHour,
    this.endHour,
  });

  factory EmergencyContact.fromMap(String id, Map<String, dynamic> map) {
    return EmergencyContact(
      id: id,
      name: map['name'] as String,
      description: map['description'] as String,
      phoneNumber: map['phoneNumber'] as String,
      startHour: map['startHour'] as int?,
      endHour: map['endHour'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'phoneNumber': phoneNumber,
      'startHour': startHour,
      'endHour': endHour,
    };
  }

  EmergencyContact copyWith({
    String? id,
    String? name,
    String? description,
    String? phoneNumber,
    int? startHour,
    int? endHour,
  }) {
    return EmergencyContact(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      startHour: startHour ?? this.startHour,
      endHour: endHour ?? this.endHour,
    );
  }
}
