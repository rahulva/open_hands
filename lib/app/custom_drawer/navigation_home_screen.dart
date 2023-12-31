import 'package:flutter/material.dart';
import 'package:open_hands/app/custom_drawer/drawer_user_controller.dart';
import 'package:open_hands/app/inbox/inbox.dart';
import 'package:open_hands/app/item_post/post_create.dart';
import 'package:open_hands/app/item_post/post_list.dart';
import 'package:open_hands/app/profile/my_posts.dart';
import 'package:open_hands/app/profile/user_login_view.dart';
import 'package:open_hands/app/profile/user_registration_view.dart';
import 'package:open_hands/app/request/request_list.dart';
import 'package:open_hands/app/screens/feedback_screen.dart';
import 'package:open_hands/app/screens/help_screen.dart';
import 'package:open_hands/app/screens/invite_friend_screen.dart';
import 'package:open_hands/app/theme/base_theme.dart';

import 'drawer_list_item.dart';

class NavigationHomeScreen extends StatefulWidget {
  final bool authenticated;

  const NavigationHomeScreen(this.authenticated, {super.key});

  @override
  State<NavigationHomeScreen> createState() {
    return _NavigationHomeScreenState();
  }
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    print("NavigationHome.initState ${widget.authenticated}");
    drawerIndex = DrawerIndex.home;
    screenView = const PostList(pageTitle: 'All Posts');
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    print("NavigationHome.setState  ${widget.authenticated}");
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BaseTheme.white,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: BaseTheme.nearlyWhite,
          body: buildBodyDrawerUserController(context),
        ),
      ),
    );
  }

  DrawerUserController buildBodyDrawerUserController(BuildContext context) {
    return DrawerUserController(
      widget.authenticated,
      screenIndex: drawerIndex,
      drawerWidth: MediaQuery.of(context).size.width * 0.75,
      onDrawerCall: (DrawerIndex drawerIndexData) {
        /* callback from drawer for replace screen as user need with passing DrawerIndex(Enum index) */
        changeIndex(drawerIndexData);
      },
      /* we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc... */
      screenView: screenView,
    );
  }

  void changeIndex(DrawerIndex drawerIndexData) {
    if (drawerIndex != drawerIndexData) {
      drawerIndex = drawerIndexData;
      switch (drawerIndex) {
        case DrawerIndex.home:
          setState(() {
            screenView = const PostList(pageTitle: 'All Posts');
          });
          break;
        case DrawerIndex.help:
          setState(() {
            screenView = HelpScreen();
          });
          break;
        case DrawerIndex.feedBack:
          setState(() {
            screenView = FeedbackScreen();
          });
          break;
        case DrawerIndex.invite:
          setState(() {
            screenView = InviteFriend();
          });
          break;
        case DrawerIndex.registration:
          setState(() {
            screenView = const UserRegistrationView();
          });
          break;
        case DrawerIndex.login:
          setState(() {
            screenView = const UserLoginView();
          });
          break;
        case DrawerIndex.newPost:
          setState(() {
            screenView = const PostCreate();
          });
          break;
        case DrawerIndex.myPosts:
          setState(() {
            screenView = const MyPosts(pageTitle: 'My Posts');
          });
          break;
        case DrawerIndex.myRequests:
          setState(() {
            screenView = const RequestList(pageTitle: 'My Requests');
          });
          break;
        case DrawerIndex.inbox:
          setState(() {
            screenView = const Inbox(pageTitle: 'Inbox');
          });
          break;
        default:
          break;
      }
    }
  }
}
