import 'package:flutter/material.dart';
import 'package:open_hands/app/components/app_password_field.dart';
import 'package:open_hands/app/components/app_text_field.dart';
import 'package:open_hands/app/theme/app_theme.dart';

class Components {
  /// This is a duplicate of appBar with the close button. TODO refactor the duplicate code.
  static Widget appBarClosable(BuildContext context, String screenTitle) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.buildLightTheme().colorScheme.background,
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.grey.withOpacity(0.2), offset: const Offset(0, 2), blurRadius: 4.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  screenTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget appBar(BuildContext context, String screenTitle) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.buildLightTheme().colorScheme.background,
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.grey.withOpacity(0.2), offset: const Offset(0, 2), blurRadius: 4.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
/*          Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),*/
            Expanded(
              child: Center(
                child: Text(
                  screenTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            )
          ],
        ),
      ),
    );
  }

  static Container button(String buttonText, Future<void> Function() saveAction) {
    return Container(
      // height: 48,
      decoration: BoxDecoration(
        color: AppTheme.buildLightTheme().primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            blurRadius: 8,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: TextButton(
            onPressed: saveAction,
            child: Center(
              child: Text(
                buttonText,
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white),
              ),
            )),
      ),
    );
  }
}

void showSuccessMessage(BuildContext context, String message) {
  final snackBar = SnackBar(content: Text(message), backgroundColor: Colors.green);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showErrorMessage(BuildContext context, String message) {
  final snackBar = SnackBar(content: Text(message), backgroundColor: Colors.red);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Container buildField(int maxLength, String hintText, var controller, String? Function(String?)? validator) {
  return Container(
    decoration: const BoxDecoration(boxShadow: []),
    child: AppTextField(maxLength, hintText: hintText, controller: controller, validator: validator),
  );
}

Container buildPasswordField(int maxLength, String hintText, var controller, String? Function(String?)? validator) {
  return Container(
    decoration: const BoxDecoration(boxShadow: []),
    child: AppPasswordField(maxLength, hintText: hintText, controller: controller, validator: validator),
  );
}

void clearFields(List fields) {
  for (var element in fields) {
    element.clear();
  }
}

Positioned favouriteIcon() {
  return Positioned(
    top: 8,
    right: 8,
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: const BorderRadius.all(
          Radius.circular(32.0),
        ),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.favorite_border,
            color: AppTheme.buildLightTheme().primaryColor,
          ),
        ),
      ),
    ),
  );
}
