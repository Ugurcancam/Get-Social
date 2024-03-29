import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlikapp/features/categories/domain/models/category_model.dart';

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getCategories() async {
    final snapshot = await _firestore.collection('event_categories').get();
    final categories = snapshot.docs.map(CategoryModel.fromSnapshot).toList();
    return categories;
  }
}
