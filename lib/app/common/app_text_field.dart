import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String? hintText;
  final TextStyle? hintStyle;
  final Icon? icon;
  final Function? onChanged;
  final TextEditingController? editingController;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    this.hintStyle,
    this.hintText,
    this.icon,
    required this.editingController,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        onChanged: (value) {
          onChanged!(value);
        },
        controller: editingController,
        decoration: buildInputDecoration(),
        validator: validator,
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
