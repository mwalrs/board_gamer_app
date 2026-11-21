import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:board_gamer_app/domain/entities/cuisine.dart';
import 'package:board_gamer_app/domain/usecases/food_submit_vote.dart';
import 'package:board_gamer_app/presentation/screens/food_voting_screen.dart';
import 'package:board_gamer_app/presentation/widgets/food/cuisine_radio_list.dart';
import 'package:board_gamer_app/presentation/widgets/food/voting_reminder_banner.dart';

class MockSubmitFoodVoteUseCase extends Mock implements SubmitFoodVoteUseCase {}

void main() {
  late MockSubmitFoodVoteUseCase mockSubmitVoteUseCase;

  setUpAll(() {
    registerFallbackValue(Cuisine.italian);
  });

  setUp(() {
    mockSubmitVoteUseCase = MockSubmitFoodVoteUseCase();
  });

  testWidgets(
    'FoodVotingScreen displays reminder banner, cuisines with example dishes and enables save on selection',
    (WidgetTester tester) async {
      when(() => mockSubmitVoteUseCase.execute(
            eventId: any(named: 'eventId'),
            userId: any(named: 'userId'),
            cuisine: any(named: 'cuisine'),
            eventDateTime: any(named: 'eventDateTime'),
          )).thenAnswer((_) async {});

      // ARRANGE
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => FoodVotingScreen(
                      eventId: 'event_1',
                      currentUserId: 'user_id',
                      eventDateTime: DateTime(2026, 11, 30, 19, 0),
                      hostName: 'Nutzer1',
                      deadlineText: '17:00 Uhr',
                      submitVoteUseCase: mockSubmitVoteUseCase,
                    ),
                  ),
                ),
                child: const Text('Open Voting'),
              ),
            ),
          ),
        ),
      );

      // Open screen
      await tester.tap(find.text('Open Voting'));
      await tester.pumpAndSettle();

      // ASSERT: Banner, RadioList and example dish are visible
      expect(find.byType(VotingReminderBanner), findsOneWidget);
      expect(find.textContaining('Nutzer1'), findsOneWidget);
      expect(find.byType(CuisineRadioList), findsOneWidget);
      expect(find.text('Italienisch'), findsOneWidget);

      // Save button is initially deactivated
      final saveButtonFinder = find.widgetWithText(ElevatedButton, 'Auswahl speichern');
      expect(tester.widget<ElevatedButton>(saveButtonFinder).onPressed, isNull);

      // ACT: Choose a cuisine
      await tester.tap(find.text('Italienisch'));
      await tester.pump();

      // ASSERT: Save button is now active
      expect(tester.widget<ElevatedButton>(saveButtonFinder).onPressed, isNotNull);

      // ACT: Save selection
      await tester.tap(saveButtonFinder);
      await tester.pumpAndSettle();

      // ASSERT: execute was called and SnackBar was shown
      verify(() => mockSubmitVoteUseCase.execute(
            eventId: 'event_1',
            userId: 'user_id',
            cuisine: Cuisine.italian,
            eventDateTime: DateTime(2026, 11, 30, 19, 0),
          )).called(1);
      expect(find.text('Stimme für „Italienisch“ gespeichert.'), findsOneWidget);
    },
  );

  testWidgets('FoodVotingScreen shows error SnackBar on VotingDeadlineExpiredException',
      (WidgetTester tester) async {
    when(() => mockSubmitVoteUseCase.execute(
          eventId: any(named: 'eventId'),
          userId: any(named: 'userId'),
          cuisine: any(named: 'cuisine'),
          eventDateTime: any(named: 'eventDateTime'),
        )).thenThrow(const VotingDeadlineExpiredException());

    await tester.pumpWidget(
      MaterialApp(
        home: FoodVotingScreen(
          eventId: 'event_1',
          currentUserId: 'user_id',
          eventDateTime: DateTime(2026, 11, 30, 19, 0),
          submitVoteUseCase: mockSubmitVoteUseCase,
        ),
      ),
    );

    await tester.tap(find.text('Burger & Pommes'));
    await tester.pump();

    final saveButtonFinder = find.widgetWithText(ElevatedButton, 'Auswahl speichern');
    await tester.tap(saveButtonFinder);
    await tester.pumpAndSettle();

    expect(find.text('Die Abstimmungsfrist (2 Stunden vor Beginn) ist bereits abgelaufen.'), findsOneWidget);
  });
}
