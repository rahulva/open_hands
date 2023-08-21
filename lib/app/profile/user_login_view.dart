import 'package:flutter/material.dart';
import 'package:http/http.dart';
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          Components.appBarClosable(context, 'Login'),
          Padding(
              padding: const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
              child: Form(
                key: _formKey,
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(boxShadow: []),
                        child: AppTextField(
                          editingController: _emailController,
                          hintText: 'Email',

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }

                            if (value.length > 50) {
                              return 'Please enter your email';
                            }

                            return null;
                          },
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(boxShadow: []),
                        child: AppTextField(
                          editingController: _passwordController,
                          hintText: 'Password',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Password';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
                        child: Components.button('Sign In', login),
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
      var userModel = UserModel('', '', _emailController.text, _passwordController.text);
      print("Email $userModel");
      Response response = await UserService.get().userLogin(userModel);
      if (response.statusCode == 201) {
        doSuccessAction();
        clearInput();
        doSuccessNavigation();
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to Login.');
      }
    }
  }

  void doSuccessAction() {
    // TODO Activate Profile,
    // TODO Parse response for profile data.
    // UserService.get().loggedInUser = // Initialized Logged in user
    // Manage state changes
  }

  void clearInput() {
    _emailController.clear();
    _passwordController.clear();
  }

  void doSuccessNavigation() {
    // TODO Navigate to home
    // Navigator.of(context)
    // .pushAndRemoveUntil(
    // MaterialPageRoute(builder:
    // (BuildContext context) => DisplayUsers(key: Key(userModel.name),)),(Route<dynamic> route) => false);
  }
}
