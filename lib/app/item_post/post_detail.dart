import 'package:flutter/material.dart';
import 'package:open_hands/app/common/Components.dart';
import 'package:open_hands/app/domain/post_model.dart';
import 'package:open_hands/app/theme/app_theme.dart';
import 'package:open_hands/app/common/image_slider.dart';

class PostDetail extends StatelessWidget {
  final PostModel postModel;

  const PostDetail({required Key key, required this.postModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      color: Colors.black,
      fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
      fontWeight: FontWeight.normal,
    );

    return Scaffold(
      backgroundColor: AppTheme.buildLightTheme().colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Components.appBarClosable(context, postModel.name),
            imageSlider(postData: postModel, context: context),
            postContent(textStyle),
          ],
        ),
      ),
    );
  }

  Container postContent(TextStyle textStyle) {
    const title = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      // color: AppTheme.creamColor,
    );

    return Container(
      // padding: const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
      decoration: BoxDecoration(
        // color: AppTheme.buildLightTheme().colorScheme.
        color: AppTheme.buildLightTheme().colorScheme.background,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(100),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          const Text("Description", style: title),
          Text(postModel.description, textAlign: TextAlign.justify),
          const SizedBox(height: 10),
          Text('${postModel.category}, ${postModel.subCategory}', textAlign: TextAlign.left, style: textStyle),
          const SizedBox(height: 10),
          const Text('Available at', textAlign: TextAlign.left, style: title),
          Text(postModel.location, textAlign: TextAlign.left, style: textStyle),
          const SizedBox(height: 10),
          const Text('Created by', textAlign: TextAlign.left, style: title),
          Text(postModel.byUser, textAlign: TextAlign.left, style: textStyle),
          const SizedBox(height: 10),
          Text('Created on ${postModel.dateTime}', textAlign: TextAlign.left, style: textStyle),
          // ),
          // TODO If it is not created by current user, show 'Request' button
          // TODO On Click of 'Request', 1 Option 1 - show - "login to request this item"
          //  Option 2 - Redirect to login page, upon successful login, redirect to

          // On 'Contact' button
          // Padding(
          //   padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 16),
          //   child: Components.button('Post', doOnSave),
          // )
        ],
      ),
    );
  }
}
