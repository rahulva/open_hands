import 'package:flutter/material.dart';
import 'package:open_hands/app/common/AppTextField.dart';
import 'package:open_hands/app/common/Components.dart';
import 'package:open_hands/app/common/post_service.dart';
import 'package:open_hands/app/domain/post_model.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

PostModel postModel = PostModel();

class _CreatePostViewState extends State<CreatePostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Components.appBarClosable(context, 'Registration'),
          Padding(
            padding: const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              buildField(
                  onChanged: (text) {
                    postModel.name = text;
                  },
                  hintText: 'Name'),
              buildField(
                  onChanged: (text) {
                    postModel.description = text;
                  },
                  hintText: 'Description'),
              buildField(
                  onChanged: (text) {
                    postModel.category = text;
                  },
                  hintText: 'Category'),
              buildField(
                  onChanged: (text) {
                    postModel.subCategory = text;
                  },
                  hintText: 'Sub Category'),
              buildField(
                  onChanged: (text) {
                    postModel.location = text;
                  },
                  hintText: 'Location or Address'),
              buildField(
                  onChanged: (text) {
                    postModel.images = text;
                  },
                  hintText: 'Images'),
              Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 16),
                  child: Components.button('Post', doOnSave))
            ]),
          )
        ])));
  }

  Container buildField({required var onChanged, required String hintText}) {
    return Container(
        decoration: const BoxDecoration(boxShadow: []), child: AppTextField(onChanged: onChanged, hintText: hintText));
  }

  Future<void> doOnSave() async {
    postModel.byUser = 'Current User';
    postModel.dateTime = DateTime.now();
    print("on save $postModel");
    var response = await PostService.get().createPost(postModel).whenComplete(() => print("Request Completed!!"));
    print("Request Completed!! ${response.statusCode}");

    if (response.statusCode == 201) {
      // Success TODO
      // Navigator.of(context)
      // .pushAndRemoveUntil(
      // MaterialPageRoute(builder:
      // (BuildContext context) => DisplayUsers(key: Key(userModel.name),)),(Route<dynamic> route) => false);
    } else {
      throw Exception('Failed to create album.');
    }
  }
}
