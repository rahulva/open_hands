import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:open_hands/app/common/app_text_area_field.dart';
import 'package:open_hands/app/common/app_text_field.dart';
import 'package:open_hands/app/common/request_service.dart';
import 'package:open_hands/app/domain/post_model.dart';
import 'package:open_hands/app/domain/request_data.dart';
import 'package:open_hands/app/domain/user_model.dart';
import 'package:uuid/uuid.dart';

import '../common/components.dart';
import '../common/validations.dart';

class RequestCreate extends StatelessWidget {
  final PostModel postData;
  final UserData currentUser;
  final uuid = const Uuid();

  RequestCreate({super.key, required this.postData, required this.currentUser});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneNoController = TextEditingController();
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
                    AppTextField(controller: _nameController, hintText: 'Contact Name', validator: validateFirstName),
                    AppTextField(controller: _emailController, hintText: 'Email', validator: validateEmail),
                    AppTextField(controller: _telephoneNoController, hintText: 'Telephone'),
                    AppTextAreaField(controller: _messageController, hintText: 'Request message..'),
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
    var requestData = RequestData(postData.id!, uuid.v1(), _nameController.text, _emailController.text,
        _telephoneNoController.text, _messageController.text, postData.byUser, DateTime.now());

    print("on save $requestData");
    var response = await RequestService.get().create(requestData).whenComplete(() => print("Request Completed!!"));
    postResponseAction(response, context);
  }

  void postResponseAction(Response response, BuildContext context) {
    print("Request Completed!! ${response.statusCode}");
    if (response.statusCode == 201) {
      clearFields([_nameController, _emailController, _telephoneNoController, _messageController]);
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
