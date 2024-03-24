import 'package:cloud_firestore/cloud_firestore.dart';

class EventCategoriesModel {
  final String name;

  EventCategoriesModel({
    required this.name,
  });

  factory EventCategoriesModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json) {
    return EventCategoriesModel(
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
