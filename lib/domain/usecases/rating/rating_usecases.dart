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
}