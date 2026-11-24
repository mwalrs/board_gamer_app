import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/food_vote_model.dart';
import '../models/restaurant_model.dart';

class FoodRemoteDataSource {
  final FirebaseFirestore _firestore;

  FoodRemoteDataSource({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  DocumentReference<Map<String, dynamic>> _eventDoc(String eventId) {
    return _firestore.collection('events').doc(eventId);
  }

  CollectionReference<Map<String, dynamic>> _votesCollection(String eventId) {
    return _eventDoc(eventId).collection('food_votes');
  }

  CollectionReference<Map<String, dynamic>> _restaurantCollection(
      String eventId) {
    return _eventDoc(eventId).collection('restaurant');
  }

  Future<void> saveVote({
    required String eventId,
    required FoodVoteModel vote,
  }) async {
    await _votesCollection(eventId).doc(vote.id).set(vote.toFirestore());
  }

  Future<List<FoodVoteModel>> fetchVotes(String eventId) async {
    final snapshot = await _votesCollection(eventId).get();
    return snapshot.docs
        .map((doc) => FoodVoteModel.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  Stream<List<FoodVoteModel>> watchVotes(String eventId) {
    return _votesCollection(eventId).snapshots().map(
          (snapshot) => snapshot.docs
          .map((doc) => FoodVoteModel.fromFirestore(doc.data(), doc.id))
          .toList(),
    );
  }

  Future<void> saveRestaurantAndStatus({
    required String eventId,
    required RestaurantModel restaurant,
    required String newFoodStatus,
  }) async {
    final batch = _firestore.batch();

    final restaurantRef = _restaurantCollection(eventId).doc(restaurant.id);
    batch.set(restaurantRef, restaurant.toFirestore());

    batch.set(
      _eventDoc(eventId),
      {'foodStatus': newFoodStatus},
      SetOptions(merge: true),
    );

    await batch.commit();
  }

  Future<RestaurantModel?> fetchRestaurant(String eventId) async {
    final snapshot = await _restaurantCollection(eventId).limit(1).get();
    if (snapshot.docs.isEmpty) return null;
    final doc = snapshot.docs.first;
    return RestaurantModel.fromFirestore(doc.data(), doc.id);
  }
}
