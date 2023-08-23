import 'package:flutter/material.dart';
import 'package:open_hands/app/custom_drawer/drawer_user_controller.dart';
import 'package:open_hands/app/hotel_booking/hotel_home_screen.dart';
import 'package:open_hands/app/item_post/post_create.dart';
import 'package:open_hands/app/item_post/post_list.dart';
import 'package:open_hands/app/profile/user_login_view.dart';
import 'package:open_hands/app/profile/user_registration_view.dart';
import 'package:open_hands/app/screens/feedback_screen.dart';
import 'package:open_hands/app/screens/help_screen.dart';
import 'package:open_hands/app/screens/invite_friend_screen.dart';
import 'package:open_hands/app/theme/base_theme.dart';

import 'drawer_list_item.dart';

class NavigationHomeScreen extends StatefulWidget {
  const NavigationHomeScreen({super.key});

  @override
  State<NavigationHomeScreen> createState() {
    return _NavigationHomeScreenState();
  }
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;
  bool loggedIn = false;

  @override
  void initState() {
    drawerIndex = DrawerIndex.home;
    screenView = const PostList();
    super.initState();
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
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexData) {
              /* callback from drawer for replace screen as user need with passing DrawerIndex(Enum index) */
              changeIndex(drawerIndexData);
            },
            /* we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc... */
            screenView: screenView,
            logginState: true,
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexData) {
    if (drawerIndex != drawerIndexData) {
      drawerIndex = drawerIndexData;
      switch (drawerIndex) {
        case DrawerIndex.home:
          setState(() {
            screenView = const PostList();
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
        case DrawerIndex.hotelHome:
          setState(() {
            screenView = const HotelHomeScreen();
          });
          break;
        case DrawerIndex.myPosts:
          setState(() {
            screenView = const PostList();
          });
          break;
        default:
          break;
      }
    }
  }
}
