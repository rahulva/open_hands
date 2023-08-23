import 'package:phone_form_field/phone_form_field.dart';

String? validatePassword(value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your Password';
  }
  return null;
}

String? validateEmail(value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  if (value.length < 10) {
    return 'Should be at least 10 characters';
  }
  if (value.length > 50) {
    return 'max 50';
  }
  return null;
}

String? validateTelephone(value) {
  if (value == null || value.isEmpty) {
    return 'Please enter contact no';
  }

  if (value.length < 10) {
    return 'Should be at least 10 characters';
  }
  if (value.length > 50) {
    return 'max 50';
  }
  return null;
}

PhoneNumberInputValidator? getValidator() {
  List<PhoneNumberInputValidator> validators = [
    PhoneValidator.required(errorText: "Please enter Telephone no."),
    PhoneValidator.validMobile(),
    PhoneValidator.valid()
  ];
  // validators.isNotEmpty ? PhoneValidator.compose(validators) : null;
  return PhoneValidator.compose(validators);
}

String? validateFirstName(value) {
  if (value == null || value.isEmpty) {
    return 'Please enter First Name';
  }
  if (value.length > 50) {
    return 'Can be maximum of 50 characters';
  }
  return null;
}

String? validateLastName(value) {
  if (value == null || value.isEmpty) {
    return 'Please enter Last Name';
  }
  if (value.length > 50) {
    return 'Can be maximum of 50 characters';
  }
  return null;
}

String? validateMessage(value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your message';
  }
  if (value.length < 10) {
    return 'Should be at least 10 characters';
  }
  if (value.length > 300) {
    return 'max 300';
  }
  return null;
}
