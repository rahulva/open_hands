import 'package:email_validator/email_validator.dart';
import 'package:phone_form_field/phone_form_field.dart';

String? validatePassword(value) {
  var msg = validateNeedValue(value);
  if (msg != null) {
    return msg;
  }
  return null;
}

String? validateEmail(value) {
  var msg = validateNeedValue(value);
  if (msg != null) {
    return msg;
  }

  if (value.length < 10) {
    return 'Should be at least 10 characters';
  }

  if (value.length > 50) {
    return 'max 50';
  }

  if (!EmailValidator.validate(value)) {
    return 'Invalid Email';
  }

  return null;
}

String? validateTelephone(value) {
  var msg = validateNeedValue(value);
  if (msg != null) {
    return msg;
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
  var msg = validateNeedValue(value);
  if (msg != null) {
    return msg;
  }
  if (value.length > 50) {
    return 'Can be maximum of 50 characters';
  }
  return null;
}

String? validateLastName(value) {
  var msg = validateNeedValue(value);
  if (msg != null) {
    return msg;
  }
  if (value.length > 50) {
    return 'Can be maximum of 50 characters';
  }
  return null;
}

String? validateMessage(value) {
  var msg = validateNeedValue(value);
  if (msg != null) {
    return msg;
  }
  if (value.length < 10) {
    return 'Should be at least 10 characters';
  }
  if (value.length > 300) {
    return 'max 300';
  }
  return null;
}

String? validatePostTitle(value) {
  var msg = validateNeedValue(value);
  if (msg != null) {
    return msg;
  }
  if (value.length < 5) {
    return 'Should be at least 5 characters';
  }
  if (value.length > 80) {
    return 'max 80';
  }
  return null;
}

String? validatePostDescription(value) {
  var msg = validateNeedValue(value);
  if (msg != null) {
    return msg;
  }
  if (value.length < 10) {
    return 'Should be at least 10 characters';
  }
  if (value.length > 300) {
    return 'max 300';
  }
  return null;
}

String? validateNeedValue(value) {
  if (value == null || value.isEmpty) {
    return '';
  }
  return null;
}
