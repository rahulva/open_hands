import 'package:flutter/material.dart';

class AppDropDownField extends StatelessWidget {
  final List<String> items;
  final String? hintText;
  final TextStyle? hintStyle;
  final Icon? icon;
  final Function(String?) onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int maxLength;

  const AppDropDownField(
    this.maxLength, {
    required this.controller,
    required this.items,
    super.key,
    this.hintStyle,
    this.hintText,
    this.icon,
    required this.onChanged,
    this.validator,
  });

  const AppDropDownField.short(
    this.maxLength,
    this.hintText,
    this.controller,
    this.items,
    this.validator, {
    super.key,
    this.hintStyle,
    this.icon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // List<DropdownMenuEntry<String>> menuItems = items
    //     .map<DropdownMenuEntry<String>>((String value) => DropdownMenuEntry<String>(value: value, label: value))
    //     .toList();

    return SizedBox(
      height: 70,
      child: DropdownButtonFormField(
        items: items
            .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(value: value, child: Text(value)))
            .toList(),
        validator: validator,
        decoration: buildInputDecoration(),
        onChanged: onChanged,
        hint: Text(hintText!),
      ),

      /* child: DropdownMenu(
        // width: 390,
        dropdownMenuEntries:
            items.map<DropdownMenuEntry<String>>((e) => DropdownMenuEntry(value: e, label: e)).toList(),
        // enableFilter: true,
        helperText: 'sel',
        errorText: 'err',
        inputDecorationTheme: InputDecorationTheme(
          border: inputBorder(),
        ),
      ),*/
    );
  }

  InputDecoration buildInputDecoration() {
    return InputDecoration(
      fillColor: const Color(0xffFFFFFF),
      filled: true,
      hintStyle: hintStyle,
      contentPadding: const EdgeInsets.only(top: 10, bottom: 10, left: 16),
      border: inputBorder(),
      enabledBorder: inputBorderEnabled(),
      hintText: hintText,
      suffixIcon: icon,
      // counter: const SizedBox.shrink(),
    );
  }

  OutlineInputBorder inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: const BorderSide(
        color: Color(0xffDEDEDF),
      ),
    );
  }

  OutlineInputBorder inputBorderEnabled() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffEBEBEC)),
    );
  }
}
