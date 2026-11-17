import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:board_gamer_app/presentation/screens/food_voting_screen.dart';
import 'package:board_gamer_app/presentation/widgets/food/cuisine_radio_list.dart';
import 'package:board_gamer_app/presentation/widgets/food/voting_reminder_banner.dart';

void main() {
  testWidgets('FoodVotingScreen displays reminder banner, cuisines with example dishes and enables save on selection',
          (WidgetTester tester) async {
        // ARRANGE
        await tester.pumpWidget(
          const MaterialApp(
            home: FoodVotingScreen(
              eventId: 'event_1',
              hostName: 'Nutzer1',
              deadlineText: '17:00 Uhr',
            ),
          ),
        );

        // ASSERT: Banner, RadioList und example dish are visible
        expect(find.byType(VotingReminderBanner), findsOneWidget);
        expect(find.textContaining('Nutzer1'), findsOneWidget);
        expect(find.byType(CuisineRadioList), findsOneWidget);
        expect(find.text('Italienisch'), findsOneWidget);

        // Save button is initial deactivated
        final saveButtonFinder = find.widgetWithText(FilledButton, 'Auswahl speichern');
        expect(tester.widget<FilledButton>(saveButtonFinder).onPressed, isNull);

        // ACT: Choose a cuisine
        await tester.tap(find.text('Italienisch'));
        await tester.pump();

        // ASSERT: Save button is now active
        expect(tester.widget<FilledButton>(saveButtonFinder).onPressed, isNotNull);
      });
}