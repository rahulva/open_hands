import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_hands/app/theme/app_theme.dart';

Widget getSearchBarUI(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.buildLightTheme().colorScheme.background,
                borderRadius: const BorderRadius.all(Radius.circular(38.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(color: Colors.grey.withOpacity(0.2), offset: const Offset(0, 2), blurRadius: 8.0)
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
                child: TextField(
                  onChanged: (String txt) {},
                  style: const TextStyle(fontSize: 18),
                  cursorColor: AppTheme.buildLightTheme().primaryColor,
                  decoration: const InputDecoration(border: InputBorder.none, hintText: 'London...'),
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.buildLightTheme().primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(38.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.grey.withOpacity(0.4), offset: const Offset(0, 2), blurRadius: 8.0),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(32.0)),
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 20,
                  color: AppTheme.buildLightTheme().colorScheme.background,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
