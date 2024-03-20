import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlikapp/features/event_room/domain/models/event_categories_model.dart';

class EventCategoriesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<EventCategoriesModel>> getEventCategories() async {
    final snapshot = await _firestore.collection('event_categories').get();
    final eventRoomData = snapshot.docs.map((doc) => EventCategoriesModel.fromSnapshot(doc)).toList();
    return eventRoomData;
  }
}
