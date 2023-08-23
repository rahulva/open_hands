import 'package:flutter/foundation.dart';
import 'package:open_hands/app/services/user_service.dart';

class Profile with ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated {
    print('Called - providers.change.notifierprovider.create');
    return _isAuthenticated;
  }

  set isAuthenticated(bool newVal) {
    _isAuthenticated = newVal;
    print(' isAuthenticated $_isAuthenticated');
    if (!newVal) {
      UserService.get().loggedInUser = null;
    }
    notifyListeners();
  }
}
