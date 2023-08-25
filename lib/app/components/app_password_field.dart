import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_hands/app/components/app_text_field.dart';

class AppPasswordField extends AppTextField {
  const AppPasswordField(super.maxLength,
      {super.key,
      super.hintStyle,
      super.hintText,
      super.icon,
      required super.controller,
      super.onChanged,
      super.validator});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: TextFormField(
        controller: controller,
        decoration: buildInputDecoration(),
        validator: validator,
        maxLength: maxLength,
        obscureText: true,
      ),
    );
  }
}
