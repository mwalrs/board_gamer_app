import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:board_gamer_app/domain/entities/cuisine.dart';
import 'package:board_gamer_app/domain/usecases/food_submit_vote.dart';
import 'package:board_gamer_app/presentation/screens/food_overview_screen.dart';
import 'package:board_gamer_app/presentation/screens/food_voting_screen.dart';
import 'package:board_gamer_app/presentation/widgets/food/food_process_status_card.dart';

import 'package:board_gamer_app/themes/app_theme.dart';

class MockSubmitFoodVoteUseCase extends Mock implements SubmitFoodVoteUseCase {}

void main() {
  late MockSubmitFoodVoteUseCase mockSubmitVoteUseCase;

  setUpAll(() {
    registerFallbackValue(Cuisine.italian);
  });

  setUp(() {
    mockSubmitVoteUseCase = MockSubmitFoodVoteUseCase();
  });

  testWidgets('FoodOverviewScreen renders status card and navigates to FoodVotingScreen',
      (WidgetTester tester) async {
    // ARRANGE
    await tester.pumpWidget(
      MaterialApp(
        home: FoodOverviewScreen(
          eventId: 'event_1',
          currentUserId: 'user_1',
          eventDateTime: DateTime(2026, 11, 30, 19, 0),
          hostName: 'Nutzer1',
          foodStatus: 'pending',
          isVotingOpen: true,
          submitVoteUseCase: mockSubmitVoteUseCase,
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

  testWidgets('FoodOverviewScreen displays host action cards only when isCurrentUserHost is true',
      (WidgetTester tester) async {
    // Test as non-host
    await tester.pumpWidget(
      MaterialApp(
        home: FoodOverviewScreen(
          eventId: 'event_1',
          currentUserId: 'user_1',
          eventDateTime: DateTime(2026, 11, 30, 19, 0),
          hostName: 'Nutzer1',
          isCurrentUserHost: false,
          submitVoteUseCase: mockSubmitVoteUseCase,
        ),
      ),
    );

    expect(find.text('Restaurant festlegen (Host)'), findsNothing);
    expect(find.text('Sammelbestellung & Abschluss (Host)'), findsNothing);

    // Test as host
    await tester.pumpWidget(
      MaterialApp(
        home: FoodOverviewScreen(
          eventId: 'event_1',
          currentUserId: 'user_1',
          eventDateTime: DateTime(2026, 11, 30, 19, 0),
          hostName: 'Nutzer1',
          isCurrentUserHost: true,
          submitVoteUseCase: mockSubmitVoteUseCase,
        ),
      ),
    );

    expect(find.text('Restaurant festlegen (Host)'), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pump();
    expect(find.text('Sammelbestellung & Abschluss (Host)'), findsOneWidget);
  });

  testWidgets('FoodOverviewScreen renders correctly with AppTheme.theme()', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.theme(),
        home: FoodOverviewScreen(
          eventId: 'event_1',
          currentUserId: 'user_1',
          eventDateTime: DateTime(2026, 11, 30, 19, 0),
          hostName: 'Gastgeber 1',
        ),
      ),
    );

    expect(find.byType(FoodOverviewScreen), findsOneWidget);
  });
}
