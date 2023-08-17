import 'package:flutter/material.dart';
import 'package:open_hands/app/common/AppTextField.dart';
import 'package:open_hands/app/common/Components.dart';
import 'package:open_hands/app/common/UserService.dart';
import 'package:open_hands/app/domain/user_model.dart';
import 'package:open_hands/app/theme/app_theme.dart';

class UserRegistrationView extends StatefulWidget {
  const UserRegistrationView({super.key});

  @override
  State<UserRegistrationView> createState() => _UserRegistrationViewState();
}

UserModel userModel = UserModel('', '', '', '');

class _UserRegistrationViewState extends State<UserRegistrationView> {
  TextEditingController firstNameController = TextEditingController(text: userModel.firsName);
  TextEditingController lastNameController = TextEditingController(text: userModel.lastName);
  TextEditingController emailController = TextEditingController(text: userModel.email);
  TextEditingController passwordController = TextEditingController(text: userModel.password);

  @override
  Widget build(BuildContext context) {
    double width2 = 300;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(children: <Widget>[
          Components.appBarClosable(context, 'Registration'),
          Padding(
            padding: const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
            child: Container(
                alignment: Alignment.topCenter,
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  buildField(
                      width: width2,
                      onChanged: (text) {
                        userModel.firsName = text;
                      },
                      hintText: 'First Name'),
                  buildField(
                      width: width2,
                      onChanged: (text) {
                        userModel.lastName = text;
                      },
                      hintText: 'Last Name'),
                  buildField(
                      width: width2,
                      onChanged: (text) {
                        userModel.email = text;
                      },
                      hintText: 'Email'),
                  buildField(
                      width: width2,
                      onChanged: (text) {
                        userModel.password = text;
                      },
                      hintText: 'Password'),
                  Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
                      child: Components.button('Signup', doOnSave))
                ])),
          )
        ]));
  }

  Container buildField({required double width, var onChanged, required String hintText}) {
    return Container(
        // width: width,
        decoration: const BoxDecoration(boxShadow: []),
        child: AppTextField(onChanged: onChanged, hintText: hintText));
  }



  Future<void> doOnSave() async {
    print("Fname ${userModel.firsName}, Lname ${userModel.lastName}");
    final text = firstNameController.text;
    print("Fname : $text");
    var response = await UserService.get().postUser(userModel).whenComplete(() => print("Request Completed!!"));
    print("Request Completed!! ${response.statusCode}");

    if (response.statusCode == 201) {
      // Success TODO
      // Navigator.of(context)
      // .pushAndRemoveUntil(
      // MaterialPageRoute(builder:
      // (BuildContext context) => DisplayUsers(key: Key(userModel.name),)),(Route<dynamic> route) => false);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }
}
