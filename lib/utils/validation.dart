bool isValidEmail(String email) {
  return email.contains('@');
}

bool isValidName(String name) {
  return !RegExp(r'[0-9]').hasMatch(name);
}
