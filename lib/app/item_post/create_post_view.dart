import 'dart:math';

import 'package:flutter/material.dart';
import 'package:open_hands/app/common/Components.dart';
import 'package:open_hands/app/common/app_text_field.dart';
import 'package:open_hands/app/common/post_service.dart';
import 'package:open_hands/app/custom_drawer/navigation_home_screen.dart';
import 'package:open_hands/app/domain/post_model.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
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
                    buildField(controller: _nameController, hintText: 'Name'),
                    buildField(controller: _descController, hintText: 'Description'),
                    buildField(controller: _categoryController, hintText: 'Category'),
                    buildField(controller: _subCategoryController, hintText: 'Sub Category'),
                    buildField(controller: _locationController, hintText: 'Location or Address'),
                    buildField(controller: _imagesController, hintText: 'Images'),
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

  Container buildField({var onChanged, required String hintText, required TextEditingController controller}) {
    return Container(
      decoration: const BoxDecoration(boxShadow: []),
      child: AppTextField(onChanged: onChanged, hintText: hintText, editingController: controller),
    );
  }

  Future<void> doOnSave() async {
    var postModel = PostModel(
        Random().nextInt(500),
        _nameController.text,
        _descController.text,
        _categoryController.text,
        _subCategoryController.text,
        _locationController.text,
        List.from(_imagesController.text.split(";")),
        DateTime.now(),
        'Current User');

    print("on save $postModel");
    var response = await PostService.get().createPost(postModel).whenComplete(() => print("Request Completed!!"));
    print("Request Completed!! ${response.statusCode}");

    if (response.statusCode == 201) {
      showSuccessMessage('Creation Success');
      clearFields();
      navigateToListPage();
    } else {
      showErrorMessage(context, 'Creation Error');
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

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message), backgroundColor: Colors.lightGreenAccent);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showErrorMessage(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message), backgroundColor: Colors.red);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
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
