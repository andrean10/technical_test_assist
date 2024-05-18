class FormatString {
  static String capitalizeEachWord(String? input) {
    if (input == null) return '';

    return input.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
}
