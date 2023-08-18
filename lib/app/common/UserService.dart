import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:open_hands/app/domain/user_model.dart';

class UserService {
  static const Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  static UserService get() {
    return UserService();
  }

  Future<http.Response> postUser(UserModel userModel) async {
    print("Value ${userModel.email} ${userModel.firsName} ${userModel.lastName} ${userModel.password}");

    return http.post(Uri.parse("http://10.0.2.2:8080/users"),
        headers: header,
        body: jsonEncode(<String, String>{
          'email': userModel.email,
          'firsName': userModel.firsName,
          'lastName': userModel.lastName,
          'password': userModel.password
        }));
  }

  Future<http.Response> userLogin(UserModel userModel) async {
    print("Value ${userModel.email} ${userModel.password}");

    return http.post(Uri.parse("http://10.0.2.2:8080/users/login"),
        headers: header,
        body: jsonEncode(<String, String>{
          'email': userModel.email,
          'firsName': userModel.firsName
        }));
  }

  Future<http.Response> getUsers() async {
    return http.get(
      Uri.parse("http://10.0.2.2:8080/users"),
      headers: <String, String>{'Context-Type': 'application/json; charset=UTF-8'},
    );
  }
}
