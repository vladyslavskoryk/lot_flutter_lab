bool isValidEmail(String email) {
  return email.contains('@');
}

bool isValidPassword(String password) {
  return password.length >= 6;
}

bool isValidName(String name) {
  return !name.contains(RegExp(r'[0-9]'));
}
