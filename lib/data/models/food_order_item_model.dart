import '../../domain/entities/food_order_item.dart';

class FoodOrderItemModel extends FoodOrderItem {
  const FoodOrderItemModel({
    required super.dish,
    required super.price,
    super.note,
  });

  factory FoodOrderItemModel.fromMap(Map<String, dynamic> map) {
    return FoodOrderItemModel(
      dish: map['dish'] as String? ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      note: map['note'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dish': dish,
      'price': price,
      'note': note,
    };
  }
}