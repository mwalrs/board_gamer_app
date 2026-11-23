import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:board_gamer_app/domain/entities/cuisine.dart';
import 'package:board_gamer_app/domain/repositories/food_repository.dart';
import 'package:board_gamer_app/domain/usecases/food_submit_vote.dart';

class MockFoodRepository extends Mock implements FoodRepository {}

void main() {
  late MockFoodRepository mockRepository;
  late SubmitFoodVoteUseCase useCase;

  setUpAll(() {
    registerFallbackValue(Cuisine.italian);
  });

  setUp(() {
    mockRepository = MockFoodRepository();
    useCase = SubmitFoodVoteUseCase(mockRepository);
  });

  test('should call repository.submitVote when deadline is not yet reached', () async {
    // ARRANGE
    final eventTime = DateTime(2026, 11, 20, 19, 0);
    final now = DateTime(2026, 11, 20, 16, 0);
    when(() => mockRepository.submitVote(
      eventId: any(named: 'eventId'),
      userId: any(named: 'userId'),
      cuisine: any(named: 'cuisine'),
    )).thenAnswer((_) async {});

    // ACT
    await useCase.execute(
      eventId: 'event_1',
      userId: 'user_1',
      cuisine: Cuisine.italian,
      eventDateTime: eventTime,
      now: now,
    );

    // ASSERT
    verify(() => mockRepository.submitVote(
      eventId: 'event_1',
      userId: 'user_1',
      cuisine: Cuisine.italian,
    )).called(1);
  });

  test('should throw VotingDeadlineExpiredException when less than 120 minutes remain', () async {
    // ARRANGE
    final eventTime = DateTime(2026, 11, 20, 19, 0);
    final now = DateTime(2026, 11, 20, 17, 30);

    // ACT & ASSERT
    expect(
      () => useCase.execute(
        eventId: 'event_1',
        userId: 'user_1',
        cuisine: Cuisine.burger,
        eventDateTime: eventTime,
        now: now,
      ),
      throwsA(isA<VotingDeadlineExpiredException>()),
    );
    verifyZeroInteractions(mockRepository);
  });

  test('VotingDeadlineExpiredException toString and default message', () {
    const exception = VotingDeadlineExpiredException();
    expect(exception.toString(), 'Die Abstimmungsfrist (2 Stunden vor Beginn) ist bereits abgelaufen.');

    const customException = VotingDeadlineExpiredException('Custom error');
    expect(customException.toString(), 'Custom error');
  });
}
