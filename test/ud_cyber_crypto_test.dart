import 'package:ud_cyber_crypto/ud_cyber_crypto.dart';
import 'package:test/test.dart';

void main() {
  group("caesarean_cipher", () {
    test("caesarean_cipher.encode() encodes the given text with a rot-n cipher "
        "using the given value of n", () {
      String text = "Alea iacta est";
      int n = 5;
      expect(caesarean_cipher.encode(text, n), equals("Fqjf nfhyf jxy"));
    });
  });
}
