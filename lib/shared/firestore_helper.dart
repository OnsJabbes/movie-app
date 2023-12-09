import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event_detail.dart';
import '../models/favorite.dart';

class FirestoreHelper {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addFavorite(EventDetail eventDetail, String uid) async {
    Favorite fav = Favorite(null, uid, eventDetail.id);

    try {
      await _db.collection('favorites').add(fav.toMap());
    } catch (error) {
      print('Error adding favorite: $error');
    }
  }

  static Future<List<Favorite>> getFavoritesForUser(String uid) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _db.collection('favorites').where('userId', isEqualTo: uid).get();

    List<Favorite> favorites = [];

    querySnapshot.docs
        .forEach((DocumentSnapshot<Map<String, dynamic>> document) {
      favorites.add(Favorite.map(document.data()!));
    });

    return favorites;
  }

  static Future<bool> isEventFavoritedByUser(String eventId, String uid) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _db
        .collection('favorites')
        .where('eventId', isEqualTo: eventId)
        .where('userId', isEqualTo: uid)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  // Add other methods as needed
}
