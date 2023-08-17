import 'package:flutter/material.dart';
import 'package:open_hands/app/custom_drawer/drawer_user_controller.dart';
import 'package:open_hands/app/custom_drawer/home_drawer.dart';
import 'package:open_hands/app/hotel_booking/hotel_home_screen.dart';
import 'package:open_hands/app/screens/feedback_screen.dart';
import 'package:open_hands/app/screens/help_screen.dart';
import 'package:open_hands/app/screens/invite_friend_screen.dart';
import 'package:open_hands/app/theme/base_theme.dart';
import 'package:open_hands/app/words_home_screen.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const HotelHomeScreen();
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
              changeIndex(drawerIndexData);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexData) {
    if (drawerIndex != drawerIndexData) {
      drawerIndex = drawerIndexData;
      switch (drawerIndex) {
        case DrawerIndex.HOME:
          setState(() {
            screenView = const HotelHomeScreen();
          });
          break;
        case DrawerIndex.WORD_HOME:
          setState(() {
            screenView = const WordHomeScreen();
          });
          break;
        case DrawerIndex.Help:
          setState(() {
            screenView = HelpScreen();
          });
          break;
        case DrawerIndex.FeedBack:
          setState(() {
            screenView = FeedbackScreen();
          });
          break;
        case DrawerIndex.Invite:
          setState(() {
            screenView = InviteFriend();
          });
          break;
        default:
          break;
      }
    }
  }
}
