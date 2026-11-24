import 'package:flutter_test/flutter_test.dart';
import 'package:board_gamer_app/domain/entities/rating_submit.dart';

void main() {
  group('RatingSubmitEntity', () {
    test('soll alle übergebenen Werte speichern', () {
      const rating = RatingSubmit(
        id: 'rating-123',
        eventId: 'event-123',
        reviewerId: 'user-123',
        hostRating: 4.0,
        foodRating: 5.0,
        eveningRating: 3.5,
      );

      expect(rating.id, 'rating-123');
      expect(rating.eventId, 'event-123');
      expect(rating.reviewerId, 'user-123');
      expect(rating.hostRating, 4.0);
      expect(rating.foodRating, 5.0);
      expect(rating.eveningRating, 3.5);
    });
  });
}