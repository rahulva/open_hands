import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_hands/app/common/app_text_field.dart';

class AppTextAreaField extends AppTextField {
  const AppTextAreaField(super.maxLength,
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
        maxLines: 5,
        maxLength: maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
      ),
    );
  }

  @override
  InputDecoration buildInputDecoration() {
    var base = super.buildInputDecoration();
    return InputDecoration(
      fillColor: base.fillColor,
      filled: base.filled,
      hintText: base.hintText,
      hintStyle: base.hintStyle,
      suffixIcon: base.icon,
      contentPadding: base.contentPadding,
      border: base.border,
      enabledBorder: base.enabledBorder,
    );
  }
}
