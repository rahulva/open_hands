import 'package:flutter/material.dart';
import 'package:open_hands/app/common/components.dart';
import 'package:open_hands/app/common/user_service.dart';
import 'package:open_hands/app/common/validations.dart';
import 'package:open_hands/app/domain/user_data.dart';
import 'package:open_hands/app/profile/user_login_view.dart';

class UserRegistrationView extends StatefulWidget {
  const UserRegistrationView({super.key});

  @override
  State<UserRegistrationView> createState() => _UserRegistrationViewState();
}

class _UserRegistrationViewState extends State<UserRegistrationView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Components.appBarClosable(context, 'Registration'),
            Padding(
              padding: const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
              child: Container(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildField('First Name', _firstNameController, validateFirstName),
                    buildField('Last Name', _lastNameController, validateLastName),
                    buildField('Email', _emailController, validateEmail),
                    buildField('Password', _passwordController, validatePassword),
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
      ),
    );
  }

  Future<void> doOnSave() async {
    // TODO Validate
    if (_formKey.currentState!.validate()) {
      var userData = UserData(
          _firstNameController.text, _lastNameController.text, _emailController.text, _passwordController.text);

      print("User DAta $userData");

      var response = await UserService.get().createUser(userData).whenComplete(() => print("Request Completed!!"));
      print("Request Completed!! ${response.statusCode}");

      if (response.statusCode == 201) {
        clearFields([_firstNameController, _lastNameController, _emailController, _passwordController]);
        if (context.mounted) {
          showSuccessMessage(context, 'Account created, please login!');
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const UserLoginView()));
          //var matRoute = MaterialPageRoute(builder: (BuildContext context) => DisplayUsers(key: Key(userData.name),)
          // Navigator.of(context).pushAndRemoveUntil(matRoute),(Route<dynamic> route) => false);
        }
      } else {
        // If the server did not return a '201 CREATED' response, throw an exception.
        if (context.mounted) {
          showErrorMessage(context, 'Registration failed');
        }
        throw Exception('Failed to create User. ${response.statusCode} ${response.body}');
      }
    }
  }
}
