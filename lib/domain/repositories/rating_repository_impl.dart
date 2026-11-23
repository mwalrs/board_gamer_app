import 'package:board_gamer_app/data/datasources/rating_remote_data_source.dart';
import 'package:board_gamer_app/data/models/rating_submit_model.dart';

import '../../domain/entities/rating_submit.dart';
import '../../domain/repositories/rating_repository.dart';

class RatingRepositoryImpl implements RatingRepository {
  final RatingRemoteDataSource _remoteDataSource;

  RatingRepositoryImpl(this._remoteDataSource);

  @override
  Future<void> saveRating(RatingSubmit rating) {
    final model = RatingSubmitModel(
      id: rating.id,
      eventId: rating.eventId,
      reviewerId: rating.reviewerId,
      hostRating: rating.hostRating,
      foodRating: rating.foodRating,
      eveningRating: rating.eveningRating,
    );

    return _remoteDataSource.saveRating(model);
  }
}