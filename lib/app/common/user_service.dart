import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:open_hands/app/domain/user_model.dart';

class UserService {
  // 'Context-Type': 'application/json; charset=UTF-8'
  static const Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  static const String uri = "http://10.0.2.2:8080/users";

  static UserService get() {
    return UserService();
  }

  Future<http.Response> createUser(UserModel userModel) async {
    print("Create User $userModel");
    return http.post(Uri.parse(uri), headers: header, body: jsonEncode(userModel));
  }

  Future<http.Response> userLogin(UserModel userModel) async {
    print("User Login $userModel");
    var loginModel = <String, String>{'email': userModel.email, 'password': userModel.password};
    return http.post(Uri.parse("$uri/login"), headers: header, body: jsonEncode(loginModel));
  }

  Future<http.Response> getUsers() async {
    return http.get(Uri.parse(uri), headers: header);
  }
}
