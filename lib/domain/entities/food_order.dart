import 'food_order_item.dart';

class FoodOrder {
  final String id;
  final String userName;
  final List<FoodOrderItem> items;
  final double totalPrice;

  const FoodOrder({
    required this.id,
    required this.userName,
    required this.items,
    required this.totalPrice,
  });
}