import 'package:flutter_test/flutter_test.dart';
import 'package:board_gamer_app/data/models/rating_submit_model.dart';

void main() {
  group('RatingSubmitModel', () {
    const rating = RatingSubmitModel(
      id: 'rating-123',
      eventId: 'event-123',
      reviewerId: 'user-123',
      hostRating: 4.0,
      foodRating: 5.0,
      eveningRating: 3.5,
    );

    test('toFirestore soll die korrekten Daten zurückgeben', () {
      final result = rating.toFirestore();

      expect(result, {
        'id': 'rating-123',
        'eventId': 'event-123',
        'reviewerId': 'user-123',
        'ratingHost': 4.0,
        'ratingFood': 5.0,
        'ratingEvening': 3.5,
      });
    });

    test('fromFirestore soll Daten korrekt auslesen', () {
      final model = RatingSubmitModel.fromFirestore({
        'eventId': 'event-123',
        'reviewerId': 'user-123',
        'ratingHost': 4,
        'ratingFood': 5,
        'ratingEvening': 3.5,
      }, 'rating-123');

      expect(model.id, 'rating-123');
      expect(model.eventId, 'event-123');
      expect(model.reviewerId, 'user-123');
      expect(model.hostRating, 4.0);
      expect(model.foodRating, 5.0);
      expect(model.eveningRating, 3.5);
    });

    test('fromFirestore soll fehlende Werte mit Standardwerten belegen', () {
      final model = RatingSubmitModel.fromFirestore({}, 'rating-123');

      expect(model.id, 'rating-123');
      expect(model.eventId, '');
      expect(model.reviewerId, '');
      expect(model.hostRating, 0.0);
      expect(model.foodRating, 0.0);
      expect(model.eveningRating, 0.0);
    });
  });
}