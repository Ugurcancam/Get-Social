import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? _uid;
  String? _namesurname;

  String? get uid => _uid;
  String? get namesurname => _namesurname;

  void setUid(String uid) {
    _uid = uid;
    //notifyListeners();
  }

  void setNameSurname(String namesurname) {
    _namesurname = namesurname;
    //notifyListeners();
  }
}
