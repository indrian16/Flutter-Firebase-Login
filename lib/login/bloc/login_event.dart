import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class LoginEvent extends Equatable {

  LoginEvent([List props = const []]) : super(props);
}

class EmailChanged extends LoginEvent {

  final String email;

  EmailChanged({@required this.email}) : super([email]);

  @override
  String toString() => 'EmailChanged { email: $email }';
}

class PasswordChanged extends LoginEvent {

  final String password;

  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class LoginWithEmailPressed extends LoginEvent {

  final String email;
  final String password;

  LoginWithEmailPressed({
    @required this.email,
    @required this.password
  }) : super([email, password]);

  @override
  String toString() => 'LoginWithEmailPressed { email: $email, password: $password }';
}

class LoginWithGooglePressed extends LoginEvent {

  @override
  String toString() => 'LoginWithGooglePressed';
}

class LoginWithFacebookPressed extends LoginEvent {

  @override
  String toString() => 'LoginWithFacebookPressed';
}