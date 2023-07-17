import 'package:flutter/material.dart';
import 'package:thesis_pubsconnect/model/user_model.dart';

class SessionProvider extends ChangeNotifier {
  UserModel? _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  UserModel? getUser() => _user;

  void clearSession() {
    _user = null;
    notifyListeners();
  }

  Future<void> refreshData(nameText, phoneText) async {
    _user!.name = nameText;
    _user!.phoneNumber = phoneText;

    notifyListeners();
  }
}
