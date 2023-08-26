import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_hands/app/theme/app_theme.dart';

Widget getAppBarUI(BuildContext context, String pageTitle) {
  return Container(
    decoration: BoxDecoration(
      color: AppTheme.buildLightTheme().colorScheme.background,
      boxShadow: <BoxShadow>[
        BoxShadow(color: Colors.grey.withOpacity(0.2), offset: const Offset(0, 2), blurRadius: 8.0),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 8, right: 8),
      child: Row(
        children: <Widget>[
          // appBarBackButtonContainer(context),
          appBarTitleContainer(pageTitle),
          // appBarLocationFavContainer(context)
        ],
      ),
    ),
  );
}

Container appBarBackButtonContainer(BuildContext context) {
  return Container(
    alignment: Alignment.centerLeft,
    width: AppBar().preferredSize.height + 40,
    height: AppBar().preferredSize.height,
    child: const Material(
      color: Colors.transparent,
      // child: InkWell(
      // borderRadius: const BorderRadius.all(
      //   Radius.circular(32.0),
      // ),
      // onTap: () {
      //   Navigator.pop(context);
      // },
      // child: const Padding(
      //   padding: EdgeInsets.all(8.0),
      //   child: Icon(Icons.arrow_back),
      // ),
      // ),
    ),
  );
}

Expanded appBarTitleContainer(String pageTitle) {
  return Expanded(
    child: SizedBox(
      width: AppBar().preferredSize.height + 40,
      height: AppBar().preferredSize.height,
      child: Center(
        child: Text(pageTitle, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 22)),
      ),
    ),
  );
}

SizedBox appBarLocationFavContainer(BuildContext context) {
  return SizedBox(
    width: AppBar().preferredSize.height + 40,
    height: AppBar().preferredSize.height,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[favoriteButton(context), locationButton(context)],
    ),
  );
}

Material favoriteButton(BuildContext context) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(32.0)),
      child: const Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.favorite_border)),
      onTap: () {},
    ),
  );
}

Material locationButton(BuildContext context) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(32.0)),
      child: const Padding(padding: EdgeInsets.all(8.0), child: Icon(FontAwesomeIcons.locationDot)),
      onTap: () {},
    ),
  );
}
