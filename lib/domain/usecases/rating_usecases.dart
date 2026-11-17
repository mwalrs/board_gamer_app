import '../../data/models/rating.dart';

class RatingUsecases {
  const RatingUsecases();

  /// Calculates the average rating from a list of ratings.
  double calculateAverageRating({
    required List<double> ratings,
  }) {
    if (ratings.isEmpty) {
      return 0.0;
    }

    final average = ratings.reduce((a, b) => a + b) / ratings.length;

    return (average * 2).round() / 2;
  }

  double calculateHostAverage(List<Rating> ratings) {
    return calculateAverageRating(
      ratings: ratings.map((r) => r.hostRating).toList(),
    );
  }

  double calculateFoodAverage(List<Rating> ratings) {
    return calculateAverageRating(
      ratings: ratings.map((r) => r.foodRating).toList(),
    );
  }

  double calculateEveningAverage(List<Rating> ratings) {
    return calculateAverageRating(
      ratings: ratings.map((r) => r.eveningRating).toList(),
    );
  }
}