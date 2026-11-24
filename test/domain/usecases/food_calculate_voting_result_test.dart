import 'package:flutter_test/flutter_test.dart';
import 'package:board_gamer_app/domain/entities/cuisine.dart';
import 'package:board_gamer_app/domain/entities/food_vote.dart';
import 'package:board_gamer_app/domain/usecases/food_calculate_voting_result.dart';

void main() {
  late CalculateFoodVotingResultUseCase useCase;

  setUp(() {
    useCase = CalculateFoodVotingResultUseCase();
  });

  group('CalculateFoodVotingResultUseCase', () {
    test('should determine single winning cuisine and calculate percentages correctly', () {
      // ARRANGE (3x Italienisch, 1x Burger -> 75% vs 25%)
      final votes = [
        FoodVote(id: 'u1', cuisine: Cuisine.italian, votedAt: DateTime(2026, 11, 20, 15, 0)),
        FoodVote(id: 'u2', cuisine: Cuisine.italian, votedAt: DateTime(2026, 11, 20, 15, 5)),
        FoodVote(id: 'u3', cuisine: Cuisine.italian, votedAt: DateTime(2026, 11, 20, 15, 10)),
        FoodVote(id: 'u4', cuisine: Cuisine.burger, votedAt: DateTime(2026, 11, 20, 15, 15)),
      ];

      // ACT
      final result = useCase.execute(votes);

      // ASSERT
      expect(result.totalVotes, 4);
      expect(result.winningCuisines, [Cuisine.italian]);
      expect(result.hasTie, isFalse);
      expect(result.percentages[Cuisine.italian], 75.0);
      expect(result.percentages[Cuisine.burger], 25.0);
      expect(result.percentages[Cuisine.sushi], 0.0);
    });

    test('should return all tied top cuisines when there is a tie', () {
      // ARRANGE (2x Italienisch, 2x Burger -> Gleichstand mit je 50%)
      final votes = [
        FoodVote(id: 'u1', cuisine: Cuisine.italian, votedAt: DateTime(2026, 11, 20, 15, 0)),
        FoodVote(id: 'u2', cuisine: Cuisine.burger, votedAt: DateTime(2026, 11, 20, 15, 5)),
        FoodVote(id: 'u3', cuisine: Cuisine.italian, votedAt: DateTime(2026, 11, 20, 15, 10)),
        FoodVote(id: 'u4', cuisine: Cuisine.burger, votedAt: DateTime(2026, 11, 20, 15, 15)),
      ];

      // ACT
      final result = useCase.execute(votes);

      // ASSERT
      expect(result.totalVotes, 4);
      expect(result.hasTie, isTrue);
      expect(result.winningCuisines, containsAll([Cuisine.italian, Cuisine.burger]));
      expect(result.winningCuisines.length, 2);
      expect(result.percentages[Cuisine.italian], 50.0);
      expect(result.percentages[Cuisine.burger], 50.0);
    });
  });
}