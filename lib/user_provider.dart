import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  String? userId;

  void setUserId(String id) {
    userId = id;
    notifyListeners();
  }
}
