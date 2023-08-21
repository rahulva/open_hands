import 'package:flutter/material.dart';
import 'package:open_hands/app/item_post/post_home_list_view.dart';

enum DrawerIndex { home, postList, feedBack, help, share, about, registration, invite, login, newPost }

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
