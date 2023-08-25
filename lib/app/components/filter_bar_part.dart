import 'package:flutter/material.dart';
import 'package:open_hands/app/theme/app_theme.dart';

import '../hotel_booking/hotel_home_screen.dart';
import '../screens/filter/filters_screen.dart';

Widget getFilterBarUI(BuildContext context, int resultCount) {
  return SliverPersistentHeader(
    pinned: true,
    floating: true,
    delegate: ContestTabHeader(
      Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 24,
              decoration: BoxDecoration(
                color: AppTheme.buildLightTheme().colorScheme.background,
                boxShadow: <BoxShadow>[
                  BoxShadow(color: Colors.grey.withOpacity(0.2), offset: const Offset(0, -2), blurRadius: 8.0),
                ],
              ),
            ),
          ),
          Container(
            color: AppTheme.buildLightTheme().colorScheme.background,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '$resultCount Records',
                        style: const TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.grey.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4.0),
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) => const FiltersScreen(), fullscreenDialog: true),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: <Widget>[
                            const Text(
                              'Filter',
                              style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 16,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.sort, color: AppTheme.buildLightTheme().primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Divider(
              height: 1,
            ),
          )
        ],
      ),
    ),
  );
}
