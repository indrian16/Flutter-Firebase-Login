import 'package:meta/meta.dart';

@immutable
class ForgotpasswordState {

  final bool isEmailValid;
  final bool isLoading;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  ForgotpasswordState({
    @required this.isEmailValid,
    @required this.isLoading,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure
  });

  factory ForgotpasswordState.isEmpty() => ForgotpasswordState(
    isEmailValid: true,
    isLoading: false,
    isSubmitting: false,
    isFailure: false,
    isSuccess: false
  );

  factory ForgotpasswordState.isLoading() => ForgotpasswordState(
    isEmailValid: true,
    isLoading: true,
    isSubmitting: true,
    isFailure: false,
    isSuccess: false
  );
  factory ForgotpasswordState.isFailure() => ForgotpasswordState(
    isEmailValid: true,
    isLoading: false,
    isSubmitting: false,
    isFailure: true,
    isSuccess: false
  );

  factory ForgotpasswordState.isSuccess() => ForgotpasswordState(
    isEmailValid: true,
    isLoading: false,
    isSubmitting: false,
    isFailure: false,
    isSuccess: true
  );

  ForgotpasswordState update({bool isEmailValid}) {

    return copyWith(isEmailValid, false, false, false, false);
  }

  ForgotpasswordState copyWith(
    bool isEmailValid,
    bool isLoading,
    bool isSubmitting,
    bool isFailure,
    bool isSuccess
  ) => ForgotpasswordState(
    isEmailValid: isEmailValid ?? this.isEmailValid,
    isLoading: isLoading ?? this.isLoading,
    isSubmitting: isSubmitting ?? this.isSubmitting,
    isFailure: isFailure ?? this.isFailure,
    isSuccess: isSuccess ?? this.isSuccess
  );

  @override
  String toString() => '''LoginState {
    isEmailValid: $isEmailValid,
    isLoading: $isLoading,
    isSubmitting: $isSubmitting,
    isFailure: $isFailure,
    isSuccess: $isSuccess
  }''';
}
