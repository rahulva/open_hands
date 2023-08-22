import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_hands/app/common/Components.dart';
import 'package:open_hands/app/common/user_service.dart';
import 'package:open_hands/app/domain/post_data.dart';
import 'package:open_hands/app/domain/user_data.dart';
import 'package:open_hands/app/profile/user_login_view.dart';
import 'package:open_hands/app/request/request_create.dart';
import 'package:open_hands/app/theme/app_theme.dart';
import 'package:open_hands/app/common/image_slider.dart';

class PostDetail extends StatelessWidget {
  final PostData postData;

  const PostDetail({required Key key, required this.postData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.buildLightTheme().colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Components.appBarClosable(context, postData.name),
            imageSlider(postData: postData, context: context),
            postContent(context),

            // )
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 85,
        // width: MediaQuery.of(context).size.width,
        //   : MainAxisAlignment.start,
        //   mainAxisSize: MainAxisSize.max,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          // mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 20),
              child:
                  // const BackButton(),
                  // alignment: Alignment.bottomRight,
                  Components.button("Request", () => showRequestPage(context)),
            ))
          ],
        ),
      ),
    );
  }

  Container postContent(BuildContext context) {
    var textStyle = TextStyle(
      color: Colors.black,
      fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
      fontWeight: FontWeight.normal,
    );
    const title = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      // color: AppTheme.creamColor,
    );

    var formatter = DateFormat('yyyy-MM-dd hh:mm:ss');

    return Container(
      // padding: const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
      alignment: Alignment.topLeft,
      // decoration: BoxDecoration(
      //   // color: AppTheme.buildLightTheme().colorScheme.
      //   color: AppTheme.buildLightTheme().colorScheme.outline,
      //   borderRadius: const BorderRadius.only(
      //     topRight: Radius.circular(100),
      //     topLeft: Radius.circular(100),
      //   ),
      // ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          const Text("Description", style: title),
          Text(postData.description, textAlign: TextAlign.justify),
          const SizedBox(height: 10),
          Text('${postData.category}, ${postData.subCategory}', textAlign: TextAlign.left, style: textStyle),
          const SizedBox(height: 10),
          const Text('Available at', textAlign: TextAlign.left, style: title),
          Text(postData.location, textAlign: TextAlign.left, style: textStyle),
          const SizedBox(height: 10),
          const Text('Created by', textAlign: TextAlign.left, style: title),
          Text(postData.byUser, textAlign: TextAlign.left, style: textStyle),
          const SizedBox(height: 10),
          const Text('Created on', textAlign: TextAlign.left, style: title),
          Text(formatter.format(postData.dateTime), textAlign: TextAlign.left, style: textStyle),
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

  showRequestPage(BuildContext context) {
    final loggedInUser = UserService.get().loggedInUser;
    if (loggedInUser != null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => RequestCreate(postData: postData, currentUser: loggedInUser)));
    } else {
      showErrorMessage(context, 'Please login to continue!');
      Navigator.push(context, MaterialPageRoute(builder: (context) => const UserLoginView()));
    }
    // If a post is requested by a person then, should not allow to request again
  }
}
