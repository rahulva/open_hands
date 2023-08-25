import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:open_hands/app/components/app_text_area_field.dart';
import 'package:open_hands/app/components/app_text_field.dart';
import 'package:open_hands/app/components/components.dart';
import 'package:open_hands/app/components/image_slider_widget.dart';
import 'package:open_hands/app/custom_drawer/navigation_home_screen.dart';
import 'package:open_hands/app/domain/post_data.dart';
import 'package:open_hands/app/services/post_service.dart';
import 'package:open_hands/app/services/user_service.dart';

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
  final ImageSliderWidget _imageWidget = ImageSliderWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Components.appBar(context, 'New Item'),
            Padding(
              padding: const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTextField.short(30, 'Name', _nameController, validatePostTitle),
                    AppTextAreaField(250,
                        hintText: 'Description', controller: _descController, validator: validatePostDescription),
                    AppTextField.short(50, 'Category', _categoryController, validateNeedValue),
                    AppTextField.short(50, 'Sub Category', _subCategoryController, validateNeedValue),
                    AppTextField.short(100, 'Location or Address', _locationController, validateNeedValue),
                    _imageWidget,
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
    print('current user email ${UserService.get().loggedInUser!.email}');
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (UserService.get().loggedInUser == null) {
      showErrorMessage(context, 'Please login to continue');
      return;
    }

    print("${_imageWidget.imageCollector.images}");

    var postData = PostData(
        null,
        _nameController.text,
        _descController.text,
        _categoryController.text,
        _subCategoryController.text,
        _locationController.text,
        [],
        DateTime.now(),
        UserService.get().loggedInUser!.email);

    print("on save $postData");
    try {
      var response = await PostService.get().createPost(postData).whenComplete(() => print("Request Completed!!"));
      print("Request Completed!! ${response.statusCode}");

      if (response.statusCode == 201) {
        var jsonDecode2 = jsonDecode(response.body) as Map<String, dynamic>;
        var imageUploadResponse = await PostService.get()
            .uploadAll(jsonDecode2['id'], List.from(_imageWidget.imageCollector.images))
            .whenComplete(() => print("Request Completed!!"));
        print(imageUploadResponse.statusCode);

        // listen for response
        imageUploadResponse.stream.transform(utf8.decoder).listen((value) {
          print(value);
        });

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
    } catch (e) {
      print('Error Incre posts $e');
      showErrorMessage(context, 'Creation Error');
    }
  }

  void navigateToListPage() {
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (BuildContext context) => const PostHomeListView()),
    //     (Route<dynamic> route) => false);
    final route = MaterialPageRoute(builder: (BuildContext context) => const NavigationHomeScreen(true));
    Navigator.of(context).push(route); //, (Route<dynamic> route) => false
  }

  void clearFields() {
    _nameController.clear();
    _categoryController.clear();
    _subCategoryController.clear();
    _imageWidget.imageCollector.reset();
    _descController.clear();
    _locationController.clear();
  }
}
