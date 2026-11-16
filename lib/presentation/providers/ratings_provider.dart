import 'package:flutter/material.dart';

import '../../domain/entities/average_ratings.dart';
import '../../domain/repositories/rating_repository.dart';
import '../../domain/usecases/rating_usecases.dart';

class RatingProvider extends ChangeNotifier {
  final RatingRepository repository;
  final RatingUsecases usecases;

  RatingProvider({
    required this.repository,
    required this.usecases,
  });

  AverageRatings? averageRatings;
  bool isLoading = false;
  String? errorMessage;

  Future<void> loadRatings(String gameId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final ratings = await repository.getRatings(gameId);

      averageRatings = AverageRatings(
        averageHost: usecases.calculateHostAverage(ratings),
        reviewCountHost: ratings.length,
        averageFood: usecases.calculateFoodAverage(ratings),
        reviewCountFood: ratings.length,
        averageEvening: usecases.calculateEveningAverage(ratings),
        reviewCountEvening: ratings.length,
      );
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
