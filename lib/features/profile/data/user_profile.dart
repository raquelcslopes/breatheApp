class UserProfile {
  final String uid;
  final String? name;
  final bool onboardingComplete;

  const UserProfile({
    required this.uid,
    this.name,
    this.onboardingComplete = false,
  });

  factory UserProfile.fromMap(String uid, Map<String, dynamic> map) {
    return UserProfile(
      uid: uid,
      name: map['name'] as String?,
      onboardingComplete: map['onboardingComplete'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'onboardingComplete': onboardingComplete};
  }

  UserProfile copyWith({String? name, bool? onboardingComplete}) {
    return UserProfile(
      uid: uid,
      name: name ?? this.name,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
    );
  }
}
