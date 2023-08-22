import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:open_hands/app/domain/user_data.dart';
import 'constants.dart';

class UserService {
  UserData? loggedInUser;
  static final UserService _userService = UserService();

  static UserService get() {
    return _userService;
  }

  Future<http.Response> createUser(UserData userData) async {
    print("Create User $userData");
    return http.post(Uri.parse(userUrl), headers: header, body: jsonEncode(userData));
  }

  Future<http.Response> userLogin(LoginData loginData) async {
    print("User Login $loginData");
    var loginModel = 'email=${loginData.email}&password=${loginData.password}';
    return http.post(Uri.parse("$userUrl/login"),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'}, body: loginModel);
  }

  Future<http.Response> getUsers() async {
    return http.get(Uri.parse(userUrl), headers: header);
  }
}

class LoginData {
  String email, password;

  LoginData(this.email, this.password);
}
