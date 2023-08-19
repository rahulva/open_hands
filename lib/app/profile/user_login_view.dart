import 'package:flutter/material.dart';
import 'package:open_hands/app/common/app_text_field.dart';
import 'package:open_hands/app/common/Components.dart';
import 'package:open_hands/app/common/user_service.dart';
import 'package:open_hands/app/domain/user_model.dart';

class UserLoginView extends StatefulWidget {
  const UserLoginView({super.key});

  @override
  State<UserLoginView> createState() => _UserLoginViewState();
}

var userModel = UserModel('', '', '', '');

class _UserLoginViewState extends State<UserLoginView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(children: <Widget>[
          Components.appBarClosable(context, 'Login'),
          Padding(
            padding: const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
            child: Container(
                alignment: Alignment.topCenter,
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  buildField(
                      onChanged: (text) {
                        userModel.email = text;
                      },
                      hintText: 'Email'),
                  buildField(
                      onChanged: (text) {
                        userModel.password = text;
                      },
                      hintText: 'Password'),
                  Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
                      child: Components.button('Sign In', login))
                ])),
          )
        ]));
  }

  Container buildField({var onChanged, required String hintText}) {
    return Container(
        decoration: const BoxDecoration(boxShadow: []), child: AppTextField(onChanged: onChanged, hintText: hintText));
  }

  Future<void> login() async {
    print("Email $userModel");

    var response = await UserService.get().userLogin(userModel).whenComplete(() => print("Login Completed!!"));
    print("Request Completed!! ${response.statusCode}");

    if (response.statusCode == 201) {
      // Success TODO Activate Profile, Navigate to home
      // Navigator.of(context)
      // .pushAndRemoveUntil(
      // MaterialPageRoute(builder:
      // (BuildContext context) => DisplayUsers(key: Key(userModel.name),)),(Route<dynamic> route) => false);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to Login.');
    }
  }
}
