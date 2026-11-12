import 'package:flutter/material.dart';
import '../widgets/food/food_process_status_card.dart';
import 'food_voting_screen.dart';

class FoodOverviewScreen extends StatelessWidget {
  final String eventId;
  final String hostName;
  final String foodStatus;
  final String? selectedRestaurantName;
  final bool isVotingOpen;
  final bool isCurrentUserHost;

  const FoodOverviewScreen({
    super.key,
    required this.eventId,
    required this.hostName,
    this.foodStatus = 'pending',
    this.selectedRestaurantName,
    this.isVotingOpen = true,
    this.isCurrentUserHost = false,
  });

  void _navigateToFoodVoting(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FoodVotingScreen(eventId: eventId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Essensbestellung'),
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
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),

          // Link to the cuisine selection
          Card(
            child: ListTile(
              leading: const Icon(Icons.restaurant),
              title: const Text('Essensrichtung wählen'),
              subtitle: Text(
                isVotingOpen
                    ? 'Favorisierte Küche für den Spieleabend abstimmen'
                    : 'Abstimmungszeitraum beendet',
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
                title: const Text('Restaurant festlegen (Host)'),
                subtitle: const Text('Voting-Ergebnis einsehen & Lieferdienst eintragen'),
                trailing: const Icon(Icons.chevron_right),
                enabled: false,
                onTap: null,
              ),
            ),
            const SizedBox(height: 8),
          ],

          // Entry point for ordering items
          Card(
            child: ListTile(
              leading: const Icon(Icons.shopping_bag_outlined),
              title: const Text('Eigene Bestellung aufgeben'),
              subtitle: const Text('Gerichte auswählen (bis zu 5 Artikel)'),
              trailing: const Icon(Icons.chevron_right),
              enabled: false,
              onTap: null,
            ),
          ),

          // Entry point for group orders (Host)
          if (isCurrentUserHost) ...[
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                leading: const Icon(Icons.receipt_long),
                title: const Text('Sammelbestellung & Abschluss (Host)'),
                subtitle: const Text('Alle Bestellungen einsehen & beim Lieferdienst bestellen'),
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