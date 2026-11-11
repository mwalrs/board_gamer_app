import '../../domain/entities/food_order.dart';
import 'food_order_item_model.dart';

class FoodOrderModel extends FoodOrder {
  const FoodOrderModel({
    required super.id,
    required super.userName,
    required super.items,
    required super.totalPrice,
  });

  factory FoodOrderModel.fromFirestore(Map<String, dynamic> data, String id) {
    final rawItems = data['items'] as List<dynamic>? ?? [];
    final parsedItems = rawItems
        .map((item) => FoodOrderItemModel.fromMap(item as Map<String, dynamic>))
        .toList();

    return FoodOrderModel(
      id: id,
      userName: data['userName'] as String? ?? '',
      items: parsedItems,
      totalPrice: (data['totalPrice'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userName': userName,
      'items': items.map((item) {
        if (item is FoodOrderItemModel) {
          return item.toMap();
        }
        return FoodOrderItemModel(
          dish: item.dish,
          price: item.price,
          note: item.note,
        ).toMap();
      }).toList(),
      'totalPrice': totalPrice,
    };
  }
}