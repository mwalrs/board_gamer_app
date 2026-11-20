import '../../domain/entities/cuisine.dart';
import '../../domain/entities/food_vote.dart';
import '../../domain/repositories/food_repository.dart';
import '../datasources/food_remote_data_source.dart';
import '../models/food_vote_model.dart';

class FoodRepositoryImpl implements FoodRepository {
  final FoodRemoteDataSource _remoteDataSource;

  FoodRepositoryImpl(this._remoteDataSource);

  @override
  Future<void> submitVote({
    required String eventId,
    required String userId,
    required Cuisine cuisine,
  }) async {
    final voteModel = FoodVoteModel(
      id: userId,
      cuisine: cuisine,
      votedAt: DateTime.now(),
    );
    await _remoteDataSource.saveVote(eventId: eventId, vote: voteModel);
  }

  @override
  Future<List<FoodVote>> getVotesForEvent(String eventId) {
    return _remoteDataSource.fetchVotes(eventId);
  }

  @override
  Stream<List<FoodVote>> watchVotesForEvent(String eventId) {
    return _remoteDataSource.watchVotes(eventId);
  }
}