import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/food_vote_model.dart';

class FoodRemoteDataSource {
  final FirebaseFirestore _firestore;

  FoodRemoteDataSource({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _votesCollection(String eventId) {
    return _firestore
        .collection('events')
        .doc(eventId)
        .collection('food_votes');
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
}