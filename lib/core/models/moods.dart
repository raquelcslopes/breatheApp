class Moods {
  final String key;
  final String title;

  const Moods({required this.key, required this.title});
}

List<Moods> moods = [
  Moods(key: 'low', title: 'Low'),
  Moods(key: 'okay', title: 'Okay'),
  Moods(key: 'good', title: 'Good'),
];
