import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String? hintText;
  final TextStyle? hintStyle;
  final Icon? icon;
  final Function? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int maxLength;

  const AppTextField(
    this.maxLength, {
    super.key,
    this.hintStyle,
    this.hintText,
    this.icon,
    required this.controller,
    this.onChanged,
    this.validator,
  });

  const AppTextField.short(
    this.maxLength,
    this.hintText,
    this.controller,
    this.validator, {
    super.key,
    this.hintStyle,
    this.icon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        controller: controller,
        decoration: buildInputDecoration(),
        validator: validator,
        maxLength: maxLength,
      ),
    );
  }

  InputDecoration buildInputDecoration() {
    return InputDecoration(
      fillColor: const Color(0xffFFFFFF),
      filled: true,
      hintText: hintText,
      hintStyle: hintStyle,
      suffixIcon: icon,
      contentPadding: const EdgeInsets.only(top: 10, bottom: 10, left: 16),
      border: inputBorder(),
      enabledBorder: inputBorderEnabled(),
      counter: const SizedBox.shrink(),
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
    return const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffEBEBEC)),
    );
  }
}
