import 'package:flutter/material.dart';
import 'package:open_hands/app/domain/profile.dart';
import 'package:open_hands/app/theme/base_theme.dart';
import 'package:provider/provider.dart';

import 'drawer_list_item.dart';
import 'navigation_home_screen.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer(
    this.loginState, {
    Key? key,
    this.screenIndex,
    this.iconAnimationController,
    this.callBackIndex,
  }) : super(key: key);

  final AnimationController? iconAnimationController;
  final DrawerIndex? screenIndex;
  final Function(DrawerIndex)? callBackIndex;
  final bool loginState;

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerListItem>? drawerList;

  @override
  void initState() {
    print("HomeDrawer: Changing state for ${widget.loginState}");
    setDrawerListArray(widget.loginState);
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    print("HomeDrawer: Set state for ${widget.loginState}");
    super.setState(fn);
  }

  void setDrawerListArray(bool loggedIn) {
    var drawerListWithUser = <DrawerListItem>[
      DrawerListItem(index: DrawerIndex.home, labelName: 'Home', icon: const Icon(Icons.home)),
      DrawerListItem(index: DrawerIndex.inbox, labelName: 'Inbox', icon: const Icon(Icons.message)),
      DrawerListItem(index: DrawerIndex.myRequests, labelName: 'My Requests', icon: const Icon(Icons.call_made_outlined)),
      DrawerListItem(index: DrawerIndex.myPosts, labelName: 'My Posts', icon: const Icon(Icons.add_circle)),
      DrawerListItem(index: DrawerIndex.newPost, labelName: 'New Post', icon: const Icon(Icons.create)),
      // DrawerListItem(index: DrawerIndex.hotelHome, labelName: 'Hotel - Temp', icon: const Icon(Icons.hotel)),
    ];
    var drawerListNoUser = <DrawerListItem>[
      DrawerListItem(index: DrawerIndex.home, labelName: 'Home', icon: const Icon(Icons.home)),
      DrawerListItem(index: DrawerIndex.registration, labelName: 'Registration', icon: const Icon(Icons.app_registration_outlined)),
      DrawerListItem(index: DrawerIndex.login, labelName: 'Login - delta', icon: const Icon(Icons.login)),
      // DrawerListItem(index: DrawerIndex.hotelHome, labelName: 'Hotel - Temp', icon: const Icon(Icons.hotel)),
    ];

    var common = [
      DrawerListItem(
          index: DrawerIndex.help, labelName: 'Help', isAssetsImage: true, imageName: 'assets/images/supportIcon.png'),
      DrawerListItem(index: DrawerIndex.feedBack, labelName: 'FeedBack', icon: const Icon(Icons.help)),
      DrawerListItem(index: DrawerIndex.invite, labelName: 'Invite Friend', icon: const Icon(Icons.group)),
      DrawerListItem(index: DrawerIndex.share, labelName: 'Rate the app', icon: const Icon(Icons.share)),
      DrawerListItem(index: DrawerIndex.about, labelName: 'About Us', icon: const Icon(Icons.info)),
    ];
    drawerListWithUser.addAll(common);
    drawerListNoUser.addAll(common);

    drawerList = loggedIn ? drawerListWithUser : drawerListNoUser;
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      backgroundColor: BaseTheme.notWhite.withOpacity(0.5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          profileIcon(isLightMode),
          const SizedBox(
            height: 4,
          ),
          Divider(
            height: 1,
            color: BaseTheme.grey.withOpacity(0.6),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: drawerList?.length,
              itemBuilder: (BuildContext context, int index) {
                return inkWell(drawerList![index]);
              },
            ),
          ),
          Divider(
            height: 1,
            color: BaseTheme.grey.withOpacity(0.6),
          ),
          Column(
            children: <Widget>[
              signOutWidget(context),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        ],
      ),
    );
  }

  Container profileIcon(bool isLightMode) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 40.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            animatedBuilder(),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 4),
              child: Text(
                'Chris Hemsworth',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isLightMode ? BaseTheme.grey : BaseTheme.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedBuilder animatedBuilder() {
    return AnimatedBuilder(
      animation: widget.iconAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return ScaleTransition(
          scale: AlwaysStoppedAnimation<double>(1.0 - (widget.iconAnimationController!.value) * 0.2),
          child: RotationTransition(
            turns: AlwaysStoppedAnimation<double>(Tween<double>(begin: 0.0, end: 24.0)
                    .animate(CurvedAnimation(parent: widget.iconAnimationController!, curve: Curves.fastOutSlowIn))
                    .value /
                360),
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(color: BaseTheme.grey.withOpacity(0.6), offset: const Offset(2.0, 4.0), blurRadius: 8),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(60.0)),
                child: Image.asset('assets/images/userImage.png', width: 100.0, height: 100.0),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget inkWell(DrawerListItem listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigateToScreen(listData.index!);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                    decoration: BoxDecoration(
                      color: widget.screenIndex == listData.index ? Colors.blue : Colors.transparent,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? Container(
                          width: 24,
                          height: 24,
                          child: Image.asset(listData.imageName,
                              color: widget.screenIndex == listData.index ? Colors.blue : BaseTheme.nearlyBlack),
                        )
                      : Icon(listData.icon?.icon,
                          color: widget.screenIndex == listData.index ? Colors.blue : BaseTheme.nearlyBlack),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: widget.screenIndex == listData.index ? Colors.black : BaseTheme.nearlyBlack,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index ? animatedBuilder2() : const SizedBox()
          ],
        ),
      ),
    );
  }

  AnimatedBuilder animatedBuilder2() {
    return AnimatedBuilder(
      animation: widget.iconAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return Transform(
          transform: Matrix4.translationValues(
              (MediaQuery.of(context).size.width * 0.75 - 64) * (1.0 - widget.iconAnimationController!.value - 1.0),
              0.0,
              0.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.75 - 64,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(28),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(28),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> navigateToScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex!(indexScreen);
  }

  StatefulBuilder signOutWidget(BuildContext context) {
    // ListTile
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setNewState) {
        if (!widget.loginState) {
          return Container();
        }
        return ListTile(
          title: const Text(
            'Sign Out',
            style: TextStyle(
              fontFamily: BaseTheme.fontName,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: BaseTheme.darkText,
            ),
            textAlign: TextAlign.left,
          ),
          trailing: const Icon(
            Icons.power_settings_new,
            color: Colors.red,
          ),
          onTap: () {
            onSignOutTapped(context);
          },
        );
      },
    );
  }

  void onSignOutTapped(BuildContext context) {
    final Profile profile = Provider.of<Profile>(context, listen: false);
    profile.isAuthenticated = false;
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const NavigationHomeScreen(false)));
  }
}
