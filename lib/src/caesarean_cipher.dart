/// Implements a rot-N encoder.
/// Two encoding methods are available: encode() implements a simple shift,
/// encodeWithKeyword() implements a shift on an alphabet beginning with the
/// unique letters in a given keyword.

class caesarean_cipher {
  static final _uppercaseLetters = ["A", "B", "C", "D", "E", "F", "G", "H", "I",
    "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X",
    "Y", "Z"];
  static final _lowercaseLetters = ["a", "b", "c", "d", "e", "f", "g", "h", "i",
    "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x",
    "y", "z"];


  /// Returns a new alphabet without duplicates that begins with 'keyword' and
  /// doesn't contain duplicates.
  static List<String> _getAlphabetFor(String keyword, List<String> alphabet) {
    List<String> newAlphabet = [];

    // First, make the first n characters of the new alphabet the first n
    // unique letters in the keyword.
    for (int i = 0; i < keyword.length; i++) {
      String letterAtIndex = _getCharacterAt(i, keyword);
      if (alphabet.contains(letterAtIndex)
          && !newAlphabet.contains(letterAtIndex)) {
        newAlphabet.add(letterAtIndex);
      }
    }

    // Then, add the rest of the alphabet sequentially to the new alphabet,
    // avoiding duplication.
    for (int i = 0; i < alphabet.length; i++) {
      String letterAtIndex = alphabet[i];
      if (!newAlphabet.contains(letterAtIndex)) {
        newAlphabet.add(letterAtIndex);
      }
    }

    return newAlphabet;
  }


  /// Returns a one-character string with the character at position 'i' in
  /// input string 'string'.
  static String _getCharacterAt(int i, String string) {
    return String.fromCharCode(string.codeUnitAt(i));
  }


  /// Returns an encoded version of 'text' using a rot-n cipher where n='shift' on
  /// the alphabet given by 'uppercaseAlphabet' and 'lowercaseAlphabet'.
  static String _getEncodedStringFor(String text, List<String> uppercaseAlphabet,
      List<String> lowercaseAlphabet, int shift) {
    String encodedText = "";
    String letter = "";

    // Get an individual character (string of length 1) from index y in the
    // text to be encoded. If the character at position i is alphabetic,
    // jump ${shift} number of characters ahead in the alphabet, starting
    // over at A if z is passed (taking the modulo ensures this).
    for (int i = 0; i < text.length; i++) {
      String newLetter = "";
      letter = _getCharacterAt(i, text);
      if (uppercaseAlphabet.contains(letter)) {
        newLetter = _getShiftedLetterFor(letter, uppercaseAlphabet, shift);
      } else if (lowercaseAlphabet.contains(letter)) {
        newLetter = _getShiftedLetterFor(letter, lowercaseAlphabet, shift);
      }
      encodedText = encodedText + newLetter;
    }

    return encodedText;
  }


  /// Returns a one-character string with the shifted value of 'letter' within
  /// the sequential list of letters given by 'alphabet'.
  static String _getShiftedLetterFor(String letter, List<String> alphabet,
      int shift) {
    return alphabet[(alphabet.indexOf(letter) + shift) % alphabet.length];
  }


  /// Encodes the 'text' parameter using a rot-n cipher with an offset given
  /// by 'shift'.
  static String encode(String text, int shift) {
    return _getEncodedStringFor(text, _uppercaseLetters, _lowercaseLetters,
        shift);
  }


  /// Encodes the 'text' parameter using a modified alphabet beginning with
  /// the letters in 'keyword' with an offset given by 'shift'.
  static String encodeWithKeyword(String text, String keyword, int shift) {
    List<String> uppercaseAlphabet = _getAlphabetFor(keyword,
        _uppercaseLetters);
    List<String> lowercaseAlphabet = _getAlphabetFor(keyword,
        _lowercaseLetters);

    return _getEncodedStringFor(text, uppercaseAlphabet, lowercaseAlphabet,
        shift);
  }
}