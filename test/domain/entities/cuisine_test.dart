import 'package:flutter_test/flutter_test.dart';
import 'package:board_gamer_app/domain/entities/cuisine.dart';

void main() {
  group('Cuisine.fromKey', () {
    test('should map known keys correctly to their enum value', () {
      expect(Cuisine.fromKey('italian'), Cuisine.italian);
      expect(Cuisine.fromKey('burger'), Cuisine.burger);
      expect(Cuisine.fromKey('doener'), Cuisine.doener);
      expect(Cuisine.fromKey('asian'), Cuisine.asian);
      expect(Cuisine.fromKey('sushi'), Cuisine.sushi);
      expect(Cuisine.fromKey('indian'), Cuisine.indian);
      expect(Cuisine.fromKey('greek'), Cuisine.greek);
    });

    test('should be case-insensitive', () {
      expect(Cuisine.fromKey('ITALIAN'), Cuisine.italian);
      expect(Cuisine.fromKey('BuRgEr'), Cuisine.burger);
    });

    test('should return Cuisine.italian as fallback for unknown or null keys', () {
      expect(Cuisine.fromKey('mexican'), Cuisine.italian);
      expect(Cuisine.fromKey(''), Cuisine.italian);
      expect(Cuisine.fromKey(null), Cuisine.italian);
    });
  });
}