import 'package:flutter/material.dart';

enum DrawerIndex {
  home,
  inbox,
  myPosts,
  newPost,
  myRequests,
  feedBack,
  help,
  share,
  about,
  invite,
  registration,
  login,
  // hotelHome,
}

class DrawerListItem {
  DrawerListItem({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex? index;
}

/*Map<DrawerIndex, Widget> getIndexScreen() {
  Map<DrawerIndex, Widget> indexScreenMap = {};
  indexScreenMap.putIfAbsent(DrawerIndex.home, () => const PostHomeListView());
  indexScreenMap.putIfAbsent(DrawerIndex.home, () => const PostHomeListView());
  return indexScreenMap;
}*/
