import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_hands/app/components/components.dart';
import 'package:open_hands/app/components/image_slider.dart';
import 'package:open_hands/app/domain/post_data.dart';
import 'package:open_hands/app/profile/user_login_view.dart';
import 'package:open_hands/app/request/request_create.dart';
import 'package:open_hands/app/services/user_service.dart';
import 'package:open_hands/app/theme/app_theme.dart';

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
            Components.appBar(context, postData.title),
            imageSlider(postData: postData, context: context),
            postContent(context),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 85,
        child: Row(
          children: [
            if (postData.createdBy != UserService.get().loggedInUser?.email)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 20),
                  child: Components.button("Request", () => showRequestPage(context)),
                ),
              )
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
    );

    var formatter = DateFormat('yyyy-MM-dd hh:mm:ss');

    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          const Text("Description", style: title),
          Text(postData.description, textAlign: TextAlign.justify),
          const SizedBox(height: 10),
          Text('${postData.category}, ${postData.condition}', textAlign: TextAlign.left, style: textStyle),
          const SizedBox(height: 10),
          const Text('Available at', textAlign: TextAlign.left, style: title),
          Text(postData.location, textAlign: TextAlign.left, style: textStyle),
          const SizedBox(height: 10),
          const Text('Created by', textAlign: TextAlign.left, style: title),
          Text(postData.createdBy, textAlign: TextAlign.left, style: textStyle),
          const SizedBox(height: 10),
          const Text('Created on', textAlign: TextAlign.left, style: title),
          Text(formatter.format(postData.dateTime), textAlign: TextAlign.left, style: textStyle),
        ],
      ),
    );
  }

  Future<void> showRequestPage(BuildContext context) async {
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
