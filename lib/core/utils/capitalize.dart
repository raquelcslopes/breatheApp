String capitalize(String text) {
  return text.isEmpty
      ? text
      : text[0].toUpperCase() + text.substring(1).toLowerCase();
}
