import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:open_hands/app/common/app_mobile_field.dart';
import 'package:open_hands/app/common/app_text_area_field.dart';
import 'package:open_hands/app/common/app_text_field.dart';
import 'package:open_hands/app/common/request_service.dart';
import 'package:open_hands/app/domain/post_data.dart';
import 'package:open_hands/app/domain/request_data.dart';
import 'package:open_hands/app/domain/user_data.dart';
import 'package:uuid/uuid.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../common/components.dart';
import '../common/validations.dart';

class RequestCreate extends StatelessWidget {
  final PostData postData;
  final UserData currentUser;
  final uuid = const Uuid();

  RequestCreate({super.key, required this.postData, required this.currentUser});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final PhoneController _phoneController = PhoneController(null);
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _emailController.text = currentUser.email;
    _nameController.text = currentUser.firstName;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Components.appBar(context, 'Request item - ${postData.id} ${postData.name}'),
            Padding(
              padding: const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTextField(50,
                        controller: _nameController, hintText: 'Contact Name', validator: validateFirstName),
                    AppTextField(50, controller: _emailController, hintText: 'Email', validator: validateEmail),
                    AppMobileField(_phoneController),
                    AppTextAreaField(300,
                        controller: _messageController, hintText: 'Request message..', validator: validateMessage),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 16),
                      child: Components.button('Send', () => doOnSubmit(context)),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> doOnSubmit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    PhoneNumber? phoneNumber = _phoneController.value;
    String phoneNo = '';
    if (phoneNumber != null) {
      phoneNo = phoneNumber.international;
      print("Internal value $phoneNo");
    } else {
      print("Invalid phone no");
      return;
    }

    var requestData = RequestData(postData.id!, uuid.v1(), _nameController.text, _emailController.text, phoneNo,
        _messageController.text, postData.byUser, DateTime.now());
    print("on save $requestData");
    var response = await RequestService.get().create(requestData).whenComplete(() => print("Request Completed!!"));
    postResponseAction(response, context);
  }

  void postResponseAction(Response response, BuildContext context) {
    print("Request Completed!! ${response.statusCode}");
    if (response.statusCode == 201) {
      _phoneController.reset();
      clearFields([_nameController, _emailController, _messageController]);
      if (context.mounted) {
        showSuccessMessage(context, 'Creation Success');
        Navigator.pop(context); // Close Request view
      }
    } else {
      if (context.mounted) {
        showErrorMessage(context, 'Creation Error');
      }
      throw Exception('Failed to create request.');
    }
  }
}
