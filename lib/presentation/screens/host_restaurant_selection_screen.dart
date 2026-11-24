import 'package:flutter/material.dart';
import '../../domain/entities/food_voting_result.dart';
import '../../domain/entities/restaurant.dart';
import '../../themes/colors.dart';
import '../widgets/food/voting_result_progress_card.dart';

class HostRestaurantSelectionScreen extends StatefulWidget {
  final String eventId;
  final FoodVotingResult votingResult;
  final Restaurant? initialRestaurant;
  final String foodStatus;
  final Future<void> Function(String name, String menuUrl)? onSaveRestaurant;

  const HostRestaurantSelectionScreen({
    super.key,
    required this.eventId,
    required this.votingResult,
    this.initialRestaurant,
    this.foodStatus = 'pending',
    this.onSaveRestaurant,
  });

  @override
  State<HostRestaurantSelectionScreen> createState() =>
      _HostRestaurantSelectionScreenState();
}

class _HostRestaurantSelectionScreenState
    extends State<HostRestaurantSelectionScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _menuUrlController;

  bool _isSaving = false;
  late bool _hasExistingRestaurant;

  bool get _isEditingLocked => widget.foodStatus == 'completed';

  @override
  void initState() {
    super.initState();
    final existing = widget.initialRestaurant;
    _hasExistingRestaurant =
        existing != null && existing.name.trim().isNotEmpty;

    _nameController = TextEditingController(text: existing?.name ?? '');
    _menuUrlController = TextEditingController(text: existing?.menu ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _menuUrlController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Bitte gib den Namen des Restaurants ein.';
    }
    return null;
  }

  String? _validateUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Bitte gib einen Link zur Speisekarte oder Bestellseite ein.';
    }
    final trimmed = value.trim();
    final uri = Uri.tryParse(trimmed);
    if (uri == null ||
        !uri.hasScheme ||
        (uri.scheme != 'http' && uri.scheme != 'https') ||
        uri.host.isEmpty) {
      return 'Bitte gib eine gültige URL (mit http:// oder https://) ein.';
    }
    return null;
  }

  Future<void> _onSavePressed() async {
    if (_isSaving || _isEditingLocked) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final name = _nameController.text.trim();
    final menuUrl = _menuUrlController.text.trim();

    setState(() => _isSaving = true);
    try {
      if (widget.onSaveRestaurant != null) {
        await widget.onSaveRestaurant!(name, menuUrl);
      }

      if (!mounted) return;
      final wasEdit = _hasExistingRestaurant;
      setState(() {
        _hasExistingRestaurant = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            wasEdit
                ? 'Restaurant „$name“ wurde aktualisiert.'
                : 'Restaurant „$name“ wurde gespeichert.',
          ),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Fehler beim Speichern des Restaurants. Bitte erneut versuchen.',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          'Restaurant festlegen',
          style: textTheme.labelMedium,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  // Voting result with LinearProgressIndicator
                  VotingResultProgressCard(
                    votingResult: widget.votingResult,
                  ),
                  const SizedBox(height: 20),

                  // Hint on subsequent Editing
                  if (_hasExistingRestaurant && !_isEditingLocked)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Card(
                        color: BoardGameColors.accent100,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.edit_note,
                                color: BoardGameColors.accent700,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Bereits hinterlegt: Du kannst Name und Link jederzeit nachträglich anpassen, bis die Bestellung abgeschlossen ist.',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: BoardGameColors.accent800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  // Formular for restaurant name and url
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _hasExistingRestaurant
                                ? 'Lieferdienst bearbeiten'
                                : 'Lieferdienst festlegen',
                            style: textTheme.labelMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Trage passend zum Voting-Ergebnis das Restaurant und den Link zur Speisekarte ein.',
                            style: textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _nameController,
                            enabled: !_isSaving && !_isEditingLocked,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: 'Name des Restaurants',
                              hintText: 'z. B. Pizzeria Da Luigi',
                              border: OutlineInputBorder(),
                            ),
                            validator: _validateName,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _menuUrlController,
                            enabled: !_isSaving && !_isEditingLocked,
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                              labelText: 'Link zur Speisekarte / Bestellseite',
                              hintText: 'https://...',
                              border: OutlineInputBorder(),
                            ),
                            validator: _validateUrl,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Fixed save button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (_isSaving || _isEditingLocked)
                      ? null
                      : _onSavePressed,
                  child: _isSaving
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : Text(
                    _hasExistingRestaurant
                        ? 'Änderungen speichern'
                        : 'Restaurant speichern',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}