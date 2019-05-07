import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class ForgotpasswordEvent extends Equatable {

  ForgotpasswordEvent([List props = const []]) : super(props);
}

class EmailChanged extends ForgotpasswordEvent {

  final String email;
  
  EmailChanged({@required this.email}) : super([email]);

  @override
  String toString() => 'EmailChanged { email: $email }';
}

class ResetPasswordPressed extends ForgotpasswordEvent {

  final String email;

  ResetPasswordPressed({@required this.email}) : super([email]);

  @override
  String toString() => 'ResetPasswordReset { email: $email }';
}
