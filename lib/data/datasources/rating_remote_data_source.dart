import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/rating_submit_model.dart';
import '../models/rating_display_model.dart';

class RatingRemoteDataSource {
  final FirebaseFirestore _firestore;

  RatingRemoteDataSource({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _ratingsCollection {
    return _firestore.collection('reviews');
  }

  // Save rating
  Future<void> saveRating(RatingSubmitModel rating) async {
    await _ratingsCollection
        .doc(rating.id)
        .set(rating.toFirestore());
  }

  // Fetch ratings for an event
  Future<List<RatingDisplayModel>> fetchRatings(String eventId) async {
    final snapshot = await _ratingsCollection
        .where('eventId', isEqualTo: eventId)
        .get();

    return snapshot.docs
        .map((doc) => RatingDisplayModel.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  // Watch ratings for an event
  Stream<List<RatingDisplayModel>> watchRatings(String eventId) {
    return _ratingsCollection
        .where('eventId', isEqualTo: eventId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map((doc) => RatingDisplayModel.fromFirestore(doc.data(), doc.id))
          .toList(),
    );
  }
}