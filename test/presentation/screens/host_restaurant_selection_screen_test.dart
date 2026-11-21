import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:board_gamer_app/domain/entities/cuisine.dart';
import 'package:board_gamer_app/domain/entities/food_voting_result.dart';
import 'package:board_gamer_app/domain/entities/restaurant.dart';
import 'package:board_gamer_app/presentation/screens/host_restaurant_selection_screen.dart';
import 'package:board_gamer_app/presentation/widgets/food/voting_result_progress_card.dart';
import 'package:board_gamer_app/themes/app_theme.dart';

void main() {
  FoodVotingResult createSampleResult({bool tie = false}) {
    if (tie) {
      return FoodVotingResult(
        totalVotes: 4,
        voteCounts: {
          for (final c in Cuisine.values)
            c: (c == Cuisine.italian || c == Cuisine.burger) ? 2 : 0,
        },
        percentages: {
          for (final c in Cuisine.values)
            c: (c == Cuisine.italian || c == Cuisine.burger) ? 50.0 : 0.0,
        },
        winningCuisines: const [Cuisine.italian, Cuisine.burger],
      );
    }

    return FoodVotingResult(
      totalVotes: 4,
      voteCounts: {
        for (final c in Cuisine.values)
          c: c == Cuisine.italian ? 3 : (c == Cuisine.burger ? 1 : 0),
      },
      percentages: {
        for (final c in Cuisine.values)
          c: c == Cuisine.italian ? 75.0 : (c == Cuisine.burger ? 25.0 : 0.0),
      },
      winningCuisines: const [Cuisine.italian],
    );
  }

  testWidgets(
    'displays voting results with LinearProgressIndicator and highlights tie winners',
        (WidgetTester tester) async {
      // ARRANGE
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.theme(),
          home: HostRestaurantSelectionScreen(
            eventId: 'event_1',
            votingResult: createSampleResult(tie: true),
          ),
        ),
      );

      // ASSERT
      expect(find.byType(VotingResultProgressCard), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsNWidgets(Cuisine.values.length));
      expect(find.textContaining('Stimmengleichstand'), findsOneWidget);
      expect(find.text('Italienisch (Favorit)'), findsOneWidget);
      expect(find.text('Burger & Pommes (Favorit)'), findsOneWidget);
    },
  );

  testWidgets(
    'validates inputs and saves new restaurant name and URL',
        (WidgetTester tester) async {
      String? savedName;
      String? savedUrl;

      // ARRANGE
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.theme(),
          home: HostRestaurantSelectionScreen(
            eventId: 'event_1',
            votingResult: createSampleResult(),
            onSaveRestaurant: (name, url) async {
              savedName = name;
              savedUrl = url;
            },
          ),
        ),
      );

      // Scroll down so form fields are inflated and visible
      await tester.drag(find.byType(ListView), const Offset(0, -400));
      await tester.pump();

      // ACT 1: Speichern ohne Eingaben -> Validierungsfehler
      final saveButton = find.widgetWithText(ElevatedButton, 'Restaurant speichern');
      await tester.tap(saveButton);
      await tester.pump();

      expect(find.text('Bitte gib den Namen des Restaurants ein.'), findsOneWidget);
      expect(savedName, isNull);

      // ACT 2: Gültige Daten eintragen und speichern
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Name des Restaurants'),
        'Pizzeria Da Luigi',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Link zur Speisekarte / Bestellseite'),
        'https://luigi-pizza.de/menue',
      );

      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      // ASSERT: Callback wurde aufgerufen und Modus wechselt auf Bearbeitung
      expect(savedName, 'Pizzeria Da Luigi');
      expect(savedUrl, 'https://luigi-pizza.de/menue');
      expect(find.text('Restaurant „Pizzeria Da Luigi“ wurde gespeichert.'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Änderungen speichern'), findsOneWidget);
    },
  );

  testWidgets(
    'pre-fills existing restaurant and allows subsequent editing',
        (WidgetTester tester) async {
      String? updatedName;
      String? updatedUrl;

      // ARRANGE: Bereits vorhandenes Restaurant übergeben
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.theme(),
          home: HostRestaurantSelectionScreen(
            eventId: 'event_1',
            votingResult: createSampleResult(),
            initialRestaurant: const Restaurant(
              id: 'host_1',
              name: 'Pizzeria Da Luigi',
              menu: 'https://luigi-pizza.de/menue',
            ),
            onSaveRestaurant: (name, url) async {
              updatedName = name;
              updatedUrl = url;
            },
          ),
        ),
      );

      // Scroll down so pre-filled form fields are inflated and visible
      await tester.drag(find.byType(ListView), const Offset(0, -400));
      await tester.pump();

      // ASSERT: Felder sind vorausgefüllt
      expect(find.text('Pizzeria Da Luigi'), findsOneWidget);
      expect(find.text('https://luigi-pizza.de/menue'), findsOneWidget);
      expect(find.text('Lieferdienst bearbeiten'), findsOneWidget);

      // ACT: Name und URL nachträglich ändern
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Name des Restaurants'),
        'Osteria Milano',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Link zur Speisekarte / Bestellseite'),
        'https://osteria-milano.de',
      );

      await tester.tap(find.widgetWithText(ElevatedButton, 'Änderungen speichern'));
      await tester.pumpAndSettle();

      // ASSERT
      expect(updatedName, 'Osteria Milano');
      expect(updatedUrl, 'https://osteria-milano.de');
      expect(find.text('Restaurant „Osteria Milano“ wurde aktualisiert.'), findsOneWidget);
    },
  );
}