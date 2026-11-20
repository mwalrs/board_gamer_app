import 'package:flutter_test/flutter_test.dart';
import 'package:board_gamer_app/domain/usecases/food_check_voting_deadline.dart';

void main() {
  late CheckVotingDeadlineUseCase useCase;

  setUp(() {
    useCase = CheckVotingDeadlineUseCase();
  });

  group('CheckVotingDeadlineUseCase', () {
    test('should return isVotingOpen == true when 121 minutes remain before event', () {
      // ARRANGE
      final eventTime = DateTime(2026, 11, 20, 19, 0);
      final now = DateTime(2026, 11, 20, 16, 59); // 121 Min. Restzeit

      // ACT
      final result = useCase.isVotingOpen(eventDateTime: eventTime, now: now);

      // ASSERT
      expect(result, isTrue);
    });

    test('should return isVotingOpen == false when less than 120 minutes remain before event', () {
      // ARRANGE
      final eventTime = DateTime(2026, 11, 20, 19, 0);
      final now = DateTime(2026, 11, 20, 17, 1); // 119 Min. Restzeit

      // ACT
      final result = useCase.isVotingOpen(eventDateTime: eventTime, now: now);

      // ASSERT
      expect(result, isFalse);
    });

    test('should trigger player reminder on dashboard when voting is open and user has not voted', () {
      // ARRANGE
      final eventTime = DateTime(2026, 11, 20, 19, 0);
      final now = DateTime(2026, 11, 20, 16, 0);

      // ACT
      final showReminder = useCase.shouldShowPlayerReminder(
        eventDateTime: eventTime,
        hasUserVoted: false,
        now: now,
      );

      // ASSERT
      expect(showReminder, isTrue);
    });

    test('should trigger host notification when deadline expired and foodStatus is pending', () {
      // ARRANGE
      final eventTime = DateTime(2026, 11, 20, 19, 0);
      final now = DateTime(2026, 11, 20, 17, 15); // Frist abgelaufen

      // ACT
      final notifyHost = useCase.shouldNotifyHostToSelectRestaurant(
        eventDateTime: eventTime,
        foodStatus: 'pending',
        isCurrentUserHost: true,
        now: now,
      );

      // ASSERT
      expect(notifyHost, isTrue);
    });
  });
}