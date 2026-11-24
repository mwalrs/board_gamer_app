import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:board_gamer_app/domain/entities/food_order.dart';
import 'package:board_gamer_app/domain/entities/restaurant.dart';
import 'package:board_gamer_app/presentation/screens/food_order_screen.dart';
import 'package:board_gamer_app/presentation/widgets/food/order_item_form_card.dart';
import 'package:board_gamer_app/presentation/widgets/food/order_total_summary_card.dart';
import 'package:board_gamer_app/themes/app_theme.dart';

void main() {
  const testRestaurant = Restaurant(
    id: 'host_1',
    name: 'Pizzeria Da Luigi',
    menu: 'https://luigi-pizza.de/menue',
  );

  testWidgets(
    'supports 0 to max 5 items dynamically and disables add button at 5 items',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 3000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      // ARRANGE: Starts with 0 artikels
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.theme(),
          home: const FoodOrderScreen(
            eventId: 'event_1',
            currentUserId: 'user_3',
            currentUserName: 'Nutzer3',
            hostName: 'Nutzer1',
            restaurant: testRestaurant,
          ),
        ),
      );

      // ASSERT: Initial 0 artikel & 0,00 €
      expect(find.byType(OrderItemFormCard), findsNothing);
      expect(find.text('0,00 €'), findsOneWidget);
      expect(find.text('Artikel hinzufügen (0/5)'), findsOneWidget);

      // ACT: add 5 artikels
      for (int i = 0; i < 5; i++) {
        final addBtn = find.byIcon(Icons.add);
        await tester.tap(addBtn);
        await tester.pump();
      }

      // ASSERT: 5 items available and add button deactivated
      expect(find.byType(OrderItemFormCard), findsNWidgets(5));
      expect(find.text('Weiteren Artikel hinzufügen (5/5)'), findsOneWidget);

      // ACT: delete one article
      final deleteBtn = find.byIcon(Icons.delete_outline).first;
      await tester.tap(deleteBtn);
      await tester.pump();

      // ASSERT: still 4 items available
      expect(find.byType(OrderItemFormCard), findsNWidgets(4));
    },
  );

  testWidgets(
    'calculates live total price dynamically and saves valid FoodOrder',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 3000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      FoodOrder? savedOrder;

      // ARRANGE
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.theme(),
          home: FoodOrderScreen(
            eventId: 'event_1',
            currentUserId: 'user_2',
            currentUserName: 'Nutzer2',
            hostName: 'Nutzer1',
            restaurant: testRestaurant,
            onSaveOrder: (order) async {
              savedOrder = order;
            },
          ),
        ),
      );

      // ACT 1: add first article and fill
      await tester.tap(find.text('Artikel hinzufügen (0/5)'));
      await tester.pump();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Gericht & Nummer').at(0),
        'Spaghetti Carbonara',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Einzelpreis (€)').at(0),
        '10,00',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Sonderwünsche / Anmerkung (optional)').at(0),
        'Extra Parmesan',
      );
      await tester.pump();

      // ASSERT 1: Live price shows 10,00 €
      expect(find.byType(OrderTotalSummaryCard), findsOneWidget);
      expect(find.text('10,00 €'), findsOneWidget);

      // ACT 2: Add second article and fill price input
      final addSecondBtn = find.text('Weiteren Artikel hinzufügen (1/5)');
      await tester.tap(addSecondBtn);
      await tester.pump();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Gericht & Nummer').at(1),
        'Knoblauchbrot',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Einzelpreis (€)').at(1),
        '3,50',
      );
      await tester.pump();

      // ASSERT 2: Live price calculate automatically to 13,50 €
      expect(find.text('13,50 €'), findsOneWidget);

      // ACT 3: Save order
      final saveBtn = find.widgetWithText(ElevatedButton, 'Bestellung speichern');
      await tester.tap(saveBtn);
      await tester.pumpAndSettle();

      // ASSERT 3: FoodOrder object was submitted correctly
      expect(savedOrder, isNotNull);
      expect(savedOrder!.id, 'user_2');
      expect(savedOrder!.userName, 'Nutzer2');
      expect(savedOrder!.items.length, 2);
      expect(savedOrder!.items[0].dish, 'Spaghetti Carbonara');
      expect(savedOrder!.items[0].note, 'Extra Parmesan');
      expect(savedOrder!.items[1].dish, 'Knoblauchbrot');
      expect(savedOrder!.items[1].note, '');
      expect(savedOrder!.totalPrice, 13.50);
    },
  );
}
