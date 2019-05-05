class Validators {

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  static isEmailValid(String email) {

    return _emailRegExp.hasMatch(email);
  }

  static isPasswordValid(String password) {

    return password.length > 3;
  }
}