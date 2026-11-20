import '../entities/cuisine.dart';
import '../repositories/food_repository.dart';
import 'food_check_voting_deadline.dart';

class VotingDeadlineExpiredException implements Exception {
  final String message;
  const VotingDeadlineExpiredException([
    this.message = 'Die Abstimmungsfrist (2 Stunden vor Beginn) ist bereits abgelaufen.',
  ]);

  @override
  String toString() => message;
}

class SubmitFoodVoteUseCase {
  final FoodRepository _repository;
  final CheckVotingDeadlineUseCase _deadlineUseCase;

  SubmitFoodVoteUseCase(
      this._repository, {
        CheckVotingDeadlineUseCase? deadlineUseCase,
      }) : _deadlineUseCase = deadlineUseCase ?? CheckVotingDeadlineUseCase();

  Future<void> execute({
    required String eventId,
    required String userId,
    required Cuisine cuisine,
    required DateTime eventDateTime,
    DateTime? now,
  }) async {
    final canVote = _deadlineUseCase.isVotingOpen(
      eventDateTime: eventDateTime,
      now: now,
    );

    if (!canVote) {
      throw const VotingDeadlineExpiredException();
    }

    await _repository.submitVote(
      eventId: eventId,
      userId: userId,
      cuisine: cuisine,
    );
  }
}