import '../../domain/entities/restaurant.dart';

class RestaurantModel extends Restaurant {
  const RestaurantModel({
    required super.id,
    required super.name,
    required super.menu,
  });

  factory RestaurantModel.fromFirestore(Map<String, dynamic> data, String id) {
    return RestaurantModel(
      id: id,
      name: data['name'] as String? ?? '',
      menu: data['menu'] as String? ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'menu': menu,
    };
  }
}