import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:open_hands/app/components/components.dart';
import 'package:open_hands/app/services/user_service.dart';
import 'package:open_hands/app/common/validations.dart';
import 'package:open_hands/app/custom_drawer/navigation_home_screen.dart';
import 'package:open_hands/app/domain/user_data.dart';
import 'package:open_hands/app/hotel_booking/hotel_home_screen.dart';
import 'package:open_hands/app/profile/user_registration_view.dart';

class UserLoginView extends StatefulWidget {
  const UserLoginView({super.key});

  @override
  State<UserLoginView> createState() => _UserLoginViewState();
}

class _UserLoginViewState extends State<UserLoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Components.appBar(context, 'Login'),
          Padding(
              padding: const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
              child: Form(
                key: _formKey,
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildField(50, 'Email', _emailController, validateEmail),
                      buildField(50,'Password', _passwordController, validatePassword),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
                        child: Components.button('Sign In', login),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
                        child: Components.button(
                            'Signup',
                            () => Navigator.push(
                                context, MaterialPageRoute(builder: (context) => const UserRegistrationView()))),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      var loginData = LoginData(_emailController.text, _passwordController.text);
      print("Login data ${loginData.toString()}");
      Response response = await UserService.get().userLogin(loginData);
      if (response.statusCode == 200) {
        var keyVal = jsonDecode(response.body);
        UserData userData = UserData(keyVal['firstName'], keyVal['lastName'], keyVal['email'], keyVal['password']);
        UserService.get().loggedInUser = userData;
        // TODO notify state change/ UI changes
        clearFields();
        if (context.mounted) {
          // Navigator.pop(context);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) => const NavigationHomeScreen()));
        } else {
          showErrorMessage(context, "Login Success Unable to navigate");
          throw Exception('Login Success Unable to navigate');
        }
      } else {
        showErrorMessage(context, "Invalid credentials");
        throw Exception('Failed to Login.');
      }
    }
  }

  void clearFields() {
    _emailController.clear();
    _passwordController.clear();
  }
}
