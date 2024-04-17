import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? _uid;
  String? _namesurname;
  String? _email;

  String? get uid => _uid;
  String? get namesurname => _namesurname;
  String? get email => _email;

  void setUid(String uid) {
    _uid = uid;
    notifyListeners();
  }

  void setNameSurname(String namesurname) {
    _namesurname = namesurname;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }
}
