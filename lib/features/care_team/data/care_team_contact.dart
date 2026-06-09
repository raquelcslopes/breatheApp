class CareTeamContact {
  final String id;
  final String name;
  final String? phoneNumber;
  final String? email;
  final String role;
  final bool? isTrustedPerson;
  final bool? hasPermissionToAcessInfo;

  const CareTeamContact({
    required this.id,
    required this.name,
    this.phoneNumber,
    this.email,
    required this.role,
    this.isTrustedPerson,
    this.hasPermissionToAcessInfo,
  });

  factory CareTeamContact.fromMap(String id, Map<String, dynamic> map) {
    return CareTeamContact(
      id: id,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      email: map['email'] as String,
      role: map['role'] as String,
      isTrustedPerson: map['isTrustedPerson'] as bool,
      hasPermissionToAcessInfo: map['hasPermissionToAcessInfo'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'role': role,
      'isTrustedPerson': isTrustedPerson,
      'hasPermissionToAcessInfo': hasPermissionToAcessInfo,
    };
  }

  CareTeamContact copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? email,
    String? role,
    bool? isTrustedPerson,
    bool? hasPermissionToAcessInfo,
  }) {
    return CareTeamContact(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      role: role ?? this.role,
      isTrustedPerson: isTrustedPerson ?? this.isTrustedPerson,
      hasPermissionToAcessInfo:
          hasPermissionToAcessInfo ?? this.hasPermissionToAcessInfo,
    );
  }
}
