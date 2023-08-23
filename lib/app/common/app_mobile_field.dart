import 'package:flutter/material.dart';
import 'package:open_hands/app/common/app_text_field.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'validations.dart';

class AppMobileField extends AppTextField {
  final PhoneController phoneController;

  const AppMobileField(this.phoneController,
      {super.key, super.hintStyle, super.hintText, super.icon, super.controller, super.onChanged, super.validator}) : super(0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: PhoneFormField(
        defaultCountry: IsoCode.DE,
        decoration: buildInputDecoration(),
        enabled: true,
        controller: phoneController,
        validator: getValidator(),
      ),
    );
  }
}
