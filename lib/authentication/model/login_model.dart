import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginModel extends ChangeNotifier {
  UserType userType;
  LoginModel({
    this.userType = UserType.guest,
  });

  UserType getUserType() {
    return userType;
  }

  void setUserType(UserType user) {
    userType = user;
    notifyListeners();
  }
}

LoginModel getLoginProvider() {
  return Provider.of<LoginModel>(GlobalKeys.navigatorKey.currentContext!,
      listen: false);
}

class GlobalKeys {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
}

enum UserType { guest, volunteer, ngo }
