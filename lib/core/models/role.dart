class Role {
  final String key;
  final String name;

  const Role({required this.key, required this.name});
}

List<Role> roles = [
  Role(key: 'psychiatrist', name: 'Psychiatrist'),

  Role(key: 'psychologist', name: 'Psychologist'),

  Role(key: 'gp', name: 'GP'),

  Role(key: 'friend', name: 'Friend'),

  Role(key: 'family', name: 'Family'),
];
