import 'package:flutter/material.dart';
import '../../domain/entities/cuisine.dart';
import '../../domain/entities/food_order.dart';
import '../../domain/entities/food_voting_result.dart';
import '../../domain/entities/restaurant.dart';
import '../../domain/usecases/food_submit_vote.dart';
import '../widgets/food/food_process_status_card.dart';
import 'food_order_screen.dart';
import 'food_voting_screen.dart';
import 'host_restaurant_selection_screen.dart';

class FoodOverviewScreen extends StatelessWidget {
  final String eventId;
  final String currentUserId;
  final DateTime eventDateTime;
  final String hostName;
  final String currentUserName;
  final String foodStatus;
  final String? selectedRestaurantName;
  final bool isVotingOpen;
  final FoodVotingResult? votingResult;
  final Restaurant? initialRestaurant;
  final FoodOrder? initialOrder;
  final bool isCurrentUserHost;
  final SubmitFoodVoteUseCase? submitVoteUseCase;

  const FoodOverviewScreen({
    super.key,
    required this.eventId,
    required this.currentUserId,
    this.currentUserName = "Spieler",
    required this.eventDateTime,
    required this.hostName,
    this.foodStatus = 'pending',
    this.selectedRestaurantName,
    this.isVotingOpen = true,
    this.votingResult,
    this.initialRestaurant,
    this.initialOrder,
    this.isCurrentUserHost = false,
    this.submitVoteUseCase,
  });

  void _navigateToFoodVoting(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FoodVotingScreen(
          eventId: eventId,
          currentUserId: currentUserId,
          eventDateTime: eventDateTime,
          hostName: hostName,
          submitVoteUseCase: submitVoteUseCase,
        ),
      ),
    );
  }

  void _navigateToHostRestaurantSelection(BuildContext context) {
    final result = votingResult ??
        FoodVotingResult(
          totalVotes: 0,
          voteCounts: {for (final c in Cuisine.values) c: 0},
          percentages: {for (final c in Cuisine.values) c: 0.0},
          winningCuisines: const [],
        );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => HostRestaurantSelectionScreen(
          eventId: eventId,
          votingResult: result,
          initialRestaurant: initialRestaurant,
          foodStatus: foodStatus,
        ),
      ),
    );
  }

  void _navigateToFoodOrder(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FoodOrderScreen(
          eventId: eventId,
          currentUserId: currentUserId,
          currentUserName: currentUserName,
          hostName: hostName,
          restaurant: initialRestaurant,
          foodStatus: foodStatus,
          initialOrder: initialOrder,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          'Essensbestellung',
          style: textTheme.labelMedium,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Info widget for the current task
          FoodProcessStatusCard(
            foodStatus: foodStatus,
            hostName: hostName,
            selectedRestaurantName: selectedRestaurantName,
            isVotingOpen: isVotingOpen,
          ),
          const SizedBox(height: 24),

          Text(
            'Aktionen',
            style: textTheme.labelMedium,
          ),
          const SizedBox(height: 12),

          // Link to the cuisine selection
          Card(
            child: ListTile(
              leading: const Icon(Icons.restaurant),
              title: Text(
                'Essensrichtung wählen',
                style: textTheme.labelMedium,
              ),
              subtitle: Text(
                isVotingOpen
                    ? 'Favorisierte Küche für den Spieleabend abstimmen'
                    : 'Abstimmungszeitraum beendet',
                style: textTheme.bodyMedium,
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _navigateToFoodVoting(context),
            ),
          ),
          const SizedBox(height: 8),

          // Entry point for the host's restaurant selection
          if (isCurrentUserHost) ...[
            Card(
              child: ListTile(
                leading: const Icon(Icons.storefront),
                title: Text(
                  'Restaurant festlegen (Host)',
                  style: textTheme.labelMedium,
                ),
                subtitle: Text(
                  'Voting-Ergebnis einsehen & Lieferdienst eintragen',
                  style: textTheme.bodyMedium,
                ),
                trailing: const Icon(Icons.chevron_right),
                enabled: true,  // later with logic
                onTap: () => _navigateToHostRestaurantSelection(context),
              ),
            ),
            const SizedBox(height: 8),
          ],

          // Entry point for ordering items
          Card(
            child: ListTile(
              leading: const Icon(Icons.shopping_bag_outlined),
              title: Text(
                'Eigene Bestellung aufgeben',
                style: textTheme.labelMedium,
              ),
              subtitle: Text(
                'Gerichte auswählen (bis zu 5 Artikel)',
                style: textTheme.bodyMedium,
              ),
              trailing: const Icon(Icons.chevron_right),
              enabled: true,
              onTap: () => _navigateToFoodOrder(context),
            ),
          ),

          // Entry point for group orders (Host)
          if (isCurrentUserHost) ...[
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                leading: const Icon(Icons.receipt_long),
                title: Text(
                  'Sammelbestellung & Abschluss (Host)',
                  style: textTheme.labelMedium,
                ),
                subtitle: Text(
                  'Alle Bestellungen einsehen & beim Lieferdienst bestellen',
                  style: textTheme.bodyMedium,
                ),
                trailing: const Icon(Icons.chevron_right),
                enabled: false,
                onTap: null,
              ),
            ),
          ],
        ],
      ),
    );
  }
}