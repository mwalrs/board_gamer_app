import '../entities/cuisine.dart';
import '../entities/food_vote.dart';
import '../entities/restaurant.dart';

abstract class FoodRepository {
  /// Saves the vote of a user for an event
  Future<void> submitVote({
    required String eventId,
    required String userId,
    required Cuisine cuisine,
  });

  /// Load all votes for an event
  Future<List<FoodVote>> getVotesForEvent(String eventId);

  /// Gets all votes for an event in realtime
  Stream<List<FoodVote>> watchVotesForEvent(String eventId);

  /// Saves or updates the selected restaurant for an event and updates foodStatus
  Future<void> saveSelectedRestaurant({
    required String eventId,
    required Restaurant restaurant,
    required String newFoodStatus,
  });

  /// Loads the currently selected restaurant for an event (null if not set yet)
  Future<Restaurant?> getSelectedRestaurant(String eventId);
}