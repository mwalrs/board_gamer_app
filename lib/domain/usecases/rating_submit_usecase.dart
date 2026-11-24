import '../entities/rating_submit.dart';
import '../repositories/rating_repository.dart';
import 'rating_submit_exceptions.dart';

class RatingSubmitUseCase {
  final RatingRepository _repository;

  RatingSubmitUseCase(this._repository);

  Future<void> execute({
    required RatingSubmit rating,
  }) async {
    if (rating.hostRating < 1 || rating.hostRating > 5 ||
        rating.foodRating < 1 || rating.foodRating > 5 ||
        rating.eveningRating < 1 || rating.eveningRating > 5) {
      throw const InvalidRatingException();
    }

    try {
      await _repository.saveRating(rating);
    } catch (e) {
      throw const RatingSubmitException();
    }
  }
}