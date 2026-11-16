import 'package:flutter_test/flutter_test.dart';
import 'package:board_gamer_app/domain/usecases/rating/rating_usecases.dart';

void main() {
  late RatingUsecases usecases;

  setUp(() {
    usecases = const RatingUsecases();
  });

  group('calculateAverageRating', () {
    test('should return average rounded to nearest half', () {
      final result = usecases.calculateAverageRating(
        ratings: [4.0, 4.5, 5.0],
      );

      expect(result, 4.5);
    });

    test('should return 0 when ratings are empty', () {
      final result = usecases.calculateAverageRating(
        ratings: [],
      );

      expect(result, 0);
    });
  });
}