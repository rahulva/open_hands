import 'package:flutter/material.dart';
import 'package:open_hands/app/common/app_text_field.dart';

class AppTextAreaField extends AppTextField {

  const AppTextAreaField(
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
      height: 70,
      child: TextFormField(
        controller: controller,
        decoration: buildInputDecoration(),
        validator: validator,
        maxLines: 5,
      ),
    );
  }
}
