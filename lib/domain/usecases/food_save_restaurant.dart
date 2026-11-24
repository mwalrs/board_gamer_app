import '../entities/restaurant.dart';
import '../repositories/food_repository.dart';

class InvalidRestaurantDataException implements Exception {
  final String message;
  const InvalidRestaurantDataException(this.message);

  @override
  String toString() => message;
}

class OrderAlreadyCompletedException implements Exception {
  final String message;
  const OrderAlreadyCompletedException([
    this.message =
    'Die Bestellung wurde bereits abgeschlossen. Das Restaurant kann nicht mehr geändert werden.',
  ]);

  @override
  String toString() => message;
}

class SaveSelectedRestaurantUseCase {
  static const String defaultRestaurantDocId = 'selected';

  final FoodRepository _repository;

  SaveSelectedRestaurantUseCase(this._repository);

  /// Checks whether a URL is syntactically valid and uses http or https
  bool isValidMenuUrl(String url) {
    final trimmed = url.trim();
    if (trimmed.isEmpty) return false;

    final uri = Uri.tryParse(trimmed);
    if (uri == null || !uri.hasScheme) return false;
    if (uri.scheme != 'http' && uri.scheme != 'https') return false;
    if (uri.host.isEmpty || !uri.host.contains('.')) return false;

    return true;
  }

  /// Determines the target status when saving the restaurant:
  /// Changes from ‘pending’ to ‘in_progress’
  String resolveNextFoodStatus(String currentFoodStatus) {
    if (currentFoodStatus == 'completed') {
      throw const OrderAlreadyCompletedException();
    }
    return 'in_progress';
  }

  /// Validates the name and menu URL, saves the restaurant, and sets foodStatus to ‘in_progress’
  /// Returns the saved [Restaurant]
  Future<Restaurant> execute({
    required String eventId,
    required String name,
    required String menuUrl,
    String currentFoodStatus = 'pending',
    String restaurantId = defaultRestaurantDocId,
  }) async {
    final trimmedName = name.trim();
    final trimmedUrl = menuUrl.trim();

    if (trimmedName.isEmpty) {
      throw const InvalidRestaurantDataException(
        'Bitte gib den Namen des Restaurants ein.',
      );
    }

    if (!isValidMenuUrl(trimmedUrl)) {
      throw const InvalidRestaurantDataException(
        'Bitte gib eine gültige Menü-URL (mit http:// oder https://) ein.',
      );
    }

    final nextStatus = resolveNextFoodStatus(currentFoodStatus);

    final restaurant = Restaurant(
      id: restaurantId,
      name: trimmedName,
      menu: trimmedUrl,
    );

    await _repository.saveSelectedRestaurant(
      eventId: eventId,
      restaurant: restaurant,
      newFoodStatus: nextStatus,
    );

    return restaurant;
  }
}