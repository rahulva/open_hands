import 'dart:math';

import 'package:flutter/material.dart';
import 'package:open_hands/app/components/components.dart';
import 'package:open_hands/app/components/app_text_field.dart';
import 'package:open_hands/app/services/post_service.dart';
import 'package:open_hands/app/custom_drawer/navigation_home_screen.dart';
import 'package:open_hands/app/domain/post_data.dart';
import '../common/validations.dart';

class PostCreate extends StatefulWidget {
  const PostCreate({super.key});

  @override
  State<PostCreate> createState() => _PostCreateState();
}

class _PostCreateState extends State<PostCreate> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _subCategoryController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _imagesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Components.appBarClosable(context, 'New Item'),
            Padding(
              padding: const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTextField(30, hintText: 'Name', controller: _nameController, validator: validatePostTitle),
                    AppTextField(100,
                        hintText: 'Description', controller: _descController, validator: validatePostDescription),
                    AppTextField(50,
                        hintText: 'Category', controller: _categoryController, validator: validateNeedValue),
                    AppTextField(50,
                        hintText: 'Sub Category', controller: _subCategoryController, validator: validateNeedValue),
                    AppTextField(100,
                        hintText: 'Location or Address', controller: _locationController, validator: validateNeedValue),
                    AppTextField(100, hintText: 'Images', controller: _imagesController),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 16),
                      child: Components.button('Post', doOnSave),
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

  Future<void> doOnSave() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    var postData = PostData(
        Random().nextInt(500),
        _nameController.text,
        _descController.text,
        _categoryController.text,
        _subCategoryController.text,
        _locationController.text,
        List.from(_imagesController.text.split(";")),
        DateTime.now(),
        'Current User');

    print("on save $postData");
    var response = await PostService.get().createPost(postData).whenComplete(() => print("Request Completed!!"));
    print("Request Completed!! ${response.statusCode}");

    if (response.statusCode == 201) {
      if (context.mounted) {
        showSuccessMessage(context, 'Creation Success');
      }
      clearFields();
      navigateToListPage();
    } else {
      if (context.mounted) {
        showErrorMessage(context, 'Creation Error');
      }
      throw Exception('Failed to create album.');
    }
  }

  void navigateToListPage() {
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (BuildContext context) => const PostHomeListView()),
    //     (Route<dynamic> route) => false);
    final route = MaterialPageRoute(builder: (BuildContext context) => const NavigationHomeScreen());
    Navigator.of(context).push(route); //, (Route<dynamic> route) => false
  }

  void clearFields() {
    _nameController.clear();
    _categoryController.clear();
    _subCategoryController.clear();
    _descController.clear();
    _imagesController.clear();
    _locationController.clear();
  }

// Widget name(BuildContext context) {
//   PostHomeListViewV2 val = PostHomeListViewV2();
//   // val.
//   return val;
// }
}
