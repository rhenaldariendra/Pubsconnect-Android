import 'package:flutter/material.dart';
import 'package:thesis_pubsconnect/model/ticket_model.dart';
import 'package:thesis_pubsconnect/model/user_model.dart';

class SessionProvider extends ChangeNotifier {
  UserModel? _user;
  TicketModel? _ticket;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void setTicket(TicketModel ticket) {
    _ticket = ticket;
    notifyListeners();
  }

  UserModel? getUser() => _user;
  TicketModel? getTicket() => _ticket;

  void clearSession() {
    _user = null;
    notifyListeners();
  }

  void clearTicket() {
    _ticket = null;
    notifyListeners();
  }

  Future<void> refreshData(nameText, phoneText) async {
    _user!.name = nameText;
    _user!.phoneNumber = phoneText;

    notifyListeners();
  }
}
