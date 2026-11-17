import 'package:flutter_test/flutter_test.dart';
import 'package:board_gamer_app/data/models/food_order_item_model.dart';
import 'package:board_gamer_app/data/models/food_order_model.dart';

void main() {
  group('FoodOrderItemModel', () {
    test('should convert Map to Model and cast integer prices to double', () {
      final map = {'dish': 'Pizza Salami', 'price': 10, 'note': 'Scharf'};
      final model = FoodOrderItemModel.fromMap(map);

      expect(model.dish, 'Pizza Salami');
      expect(model.price, 10.0);
      expect(model.note, 'Scharf');
    });

    test('should convert Model to Map with matching fields', () {
      const model = FoodOrderItemModel(dish: 'Cola', price: 2.50, note: '');
      final map = model.toMap();

      expect(map, {'dish': 'Cola', 'price': 2.50, 'note': ''});
    });
  });

  group('FoodOrderModel', () {
    test('should parse Firestore document with nested item list', () {
      final firestoreData = {
        'userName': 'Nutzer2',
        'items': [
          {'dish': 'Spaghetti', 'price': 10.0, 'note': 'Viel Käse'},
          {'dish': 'Pizzabrot', 'price': 3.50, 'note': ''},
        ],
        'totalPrice': 13.50,
      };

      final order = FoodOrderModel.fromFirestore(firestoreData, 'order_123');

      expect(order.id, 'order_123');
      expect(order.userName, 'Nutzer2');
      expect(order.items.length, 2);
      expect(order.items[0].dish, 'Spaghetti');
      expect(order.totalPrice, 13.50);
    });

    test('should serialize to Firestore map format correctly', () {
      const item1 = FoodOrderItemModel(dish: 'Döner', price: 7.0, note: 'Ohne Zwiebeln');
      const order = FoodOrderModel(
        id: 'order_456',
        userName: 'Nutzer3',
        items: [item1],
        totalPrice: 7.0,
      );

      final map = order.toFirestore();

      expect(map['userName'], 'Nutzer3');
      expect(map['totalPrice'], 7.0);
      expect((map['items'] as List).length, 1);
      expect((map['items'] as List)[0]['dish'], 'Döner');
    });
  });
}