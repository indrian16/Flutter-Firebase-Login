import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class AuthenticationState extends Equatable {

  AuthenticationState([List props = const []]) : super(props);
}
  
class Uninitilized extends AuthenticationState {

  @override
  String toString() => 'Uninitilized';
}

class Authenticated extends AuthenticationState {

  final String displayEmail;

  Authenticated({this.displayEmail}) : super([displayEmail]);

  @override
  String toString() => 'Authenticated { displayEmail: $displayEmail }';
}

class Unauthenticated extends AuthenticationState {

  @override
  String toString() => 'Unauthenticated';
}