import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:board_gamer_app/presentation/screens/food_overview_screen.dart';
import 'package:board_gamer_app/presentation/screens/food_voting_screen.dart';
import 'package:board_gamer_app/presentation/widgets/food/food_process_status_card.dart';

void main() {
  testWidgets('FoodOverviewScreen renders status card and navigates to FoodVotingScreen',
          (WidgetTester tester) async {
        // ARRANGE
        await tester.pumpWidget(
          const MaterialApp(
            home: FoodOverviewScreen(
              eventId: 'event_1',
              hostName: 'Nutzer1',
              foodStatus: 'pending',
              isVotingOpen: true,
            ),
          ),
        );

        // ASSERT: Status-Widget and headline were shown
        expect(find.byType(FoodProcessStatusCard), findsOneWidget);
        expect(find.text('Abstimmung über Essensrichtung'), findsOneWidget);
        expect(find.text('Essensrichtung wählen'), findsOneWidget);

        // ACT: tap on "Essensrichtung wählen"
        await tester.tap(find.text('Essensrichtung wählen'));
        await tester.pumpAndSettle();

        // ASSERT: You have been redirected to the FoodVotingScreen
        expect(find.byType(FoodVotingScreen), findsOneWidget);
      });
}