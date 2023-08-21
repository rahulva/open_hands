import 'package:flutter/material.dart';
import 'package:open_hands/app/common/app_text_field.dart';
import 'package:open_hands/app/common/Components.dart';
import 'package:open_hands/app/common/user_service.dart';
import 'package:open_hands/app/domain/user_model.dart';
import 'package:open_hands/app/profile/user_login_view.dart';

class UserRegistrationView extends StatefulWidget {
  const UserRegistrationView({super.key});

  @override
  State<UserRegistrationView> createState() => _UserRegistrationViewState();
}

UserModel userModel = UserModel('', '', '', '');

class _UserRegistrationViewState extends State<UserRegistrationView> {
  TextEditingController _firstNameController = TextEditingController(text: userModel.firsName);
  TextEditingController _lastNameController = TextEditingController(text: userModel.lastName);
  TextEditingController _emailController = TextEditingController(text: userModel.email);
  TextEditingController _passwordController = TextEditingController(text: userModel.password);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          Components.appBarClosable(context, 'Registration'),
          Padding(
            padding: const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
            child: Container(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildField(hintText: 'First Name', controller: _firstNameController),
                  buildField(hintText: 'Last Name', controller: _lastNameController),
                  buildField(hintText: 'Email', controller: _emailController),
                  buildField(hintText: 'Password', controller: _passwordController),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
                    child: Components.button('Signup', doOnSave),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildField({required var controller, required String hintText}) {
    return Container(
      decoration: const BoxDecoration(boxShadow: []),
      child: AppTextField(hintText: hintText, editingController: controller),
    );
  }

  Future<void> doOnSave() async {
    print("Fname ${userModel.firsName}, Lname ${userModel.lastName}");
    var response = await UserService.get().createUser(userModel).whenComplete(() => print("Request Completed!!"));
    print("Request Completed!! ${response.statusCode}");

    if (response.statusCode == 201) {
      doSuccessAction();
      showSuccessMessage('Account created, please login!');
      doSuccessNavigation();
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message), backgroundColor: Colors.lightGreenAccent);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void notifySuccess() {}

  void doSuccessAction() {}

  void doSuccessNavigation() {
    // TODO
    // Navigator.of(context)
    // .pushAndRemoveUntil(
    // MaterialPageRoute(builder:
    // (BuildContext context) => DisplayUsers(key: Key(userModel.name),)),(Route<dynamic> route) => false);
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const UserLoginView()));
  }
}
