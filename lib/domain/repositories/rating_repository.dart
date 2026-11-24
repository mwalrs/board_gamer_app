import 'package:board_gamer_app/domain/entities/rating_submit.dart';

abstract class RatingRepository {
  Future<void> saveRating(RatingSubmit rating);
}