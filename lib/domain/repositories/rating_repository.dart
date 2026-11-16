import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/models/rating.dart';
import '../entities/rating_model.dart';

class RatingRepository {
  final FirebaseFirestore firestore;

  RatingRepository(this.firestore);

  Future<List<Rating>> getRatings(String gameId) async {
    final snapshot = await firestore
        .collection('games')
        .doc(gameId)
        .collection('ratings')
        .get();

    return snapshot.docs
        .map((doc) => RatingModel.fromFirestore(doc.data(), doc.id))
        .toList();
  }
}
