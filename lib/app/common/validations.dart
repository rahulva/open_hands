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
