import 'package:flutter/material.dart';
import '../../data/datasources/food_remote_data_source.dart';
import '../../data/repositories/food_repository_impl.dart';
import '../../domain/entities/cuisine.dart';
import '../../domain/usecases/food_check_voting_deadline.dart';
import '../../domain/usecases/food_submit_vote.dart';
import '../widgets/food/cuisine_radio_list.dart';
import '../widgets/food/voting_reminder_banner.dart';

class FoodVotingScreen extends StatefulWidget {
  final String eventId;
  final String currentUserId;
  final DateTime eventDateTime;
  final String hostName;
  final String? deadlineText;
  final Cuisine? initialSelectedCuisine;
  final SubmitFoodVoteUseCase? submitVoteUseCase;

  const FoodVotingScreen({
    super.key,
    required this.eventId,
    required this.currentUserId,
    required this.eventDateTime,
    this.hostName = 'Gastgeber',  // TODO: later with real hostName
    this.deadlineText,
    this.initialSelectedCuisine,
    this.submitVoteUseCase,
  });

  @override
  State<FoodVotingScreen> createState() => _FoodVotingScreenState();
}

class _FoodVotingScreenState extends State<FoodVotingScreen> {
  late Cuisine? _selectedCuisine;
  final CheckVotingDeadlineUseCase _deadlineUseCase = CheckVotingDeadlineUseCase();
  bool _isSaving = false;

  SubmitFoodVoteUseCase get _submitUseCase =>
      widget.submitVoteUseCase ??
      SubmitFoodVoteUseCase(FoodRepositoryImpl(FoodRemoteDataSource()));

  @override
  void initState() {
    super.initState();
    _selectedCuisine = widget.initialSelectedCuisine;
  }

  Future<void> _onSavePressed() async {
    if (_selectedCuisine == null || _isSaving) return;

    setState(() => _isSaving = true);
    try {
      await _submitUseCase.execute(
        eventId: widget.eventId,
        userId: widget.currentUserId,
        cuisine: _selectedCuisine!,
        eventDateTime: widget.eventDateTime,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Stimme für „${_selectedCuisine!.displayName}“ gespeichert.'),
        ),
      );
      Navigator.of(context).pop(true);
    } on VotingDeadlineExpiredException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fehler beim Speichern der Stimme. Bitte erneut versuchen.'),
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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isVotingOpen = _deadlineUseCase.isVotingOpen(
      eventDateTime: widget.eventDateTime,
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          'Essensrichtung wählen',
          style: textTheme.labelMedium,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // reminder banner
                VotingReminderBanner(
                  hostName: widget.hostName,
                  deadlineText: widget.deadlineText,
                ),
                const SizedBox(height: 20),
                // headline
                Text(
                  'Worauf hast du heute Appetit?',
                  style: textTheme.labelMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Wähle deine bevorzugte Essensrichtung:',
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),

                // RadioList for choosing cuisine
                CuisineRadioList(
                  selectedCuisine: _selectedCuisine,
                  enabled: isVotingOpen && !_isSaving,
                  onChanged: (Cuisine? value) {
                    setState(() => _selectedCuisine = value);
                  },
                ),
              ],
            ),
          ),

          // fixed Save-Button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isVotingOpen && _selectedCuisine != null && !_isSaving
                      ? _onSavePressed
                      : null,
                  child: _isSaving
                      ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                      : Text('Auswahl speichern',
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
