import 'package:meta/meta.dart';

@immutable
class LoginState {

  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isLoading;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;

  LoginState({
    @required this.isEmailValid, 
    @required this.isPasswordValid,
    @required this.isLoading,
    @required this.isSubmitting, 
    @required this.isSuccess, 
    @required this.isFailure});

  factory LoginState.isEmpty() => LoginState(
    isEmailValid: true,
    isPasswordValid: true,
    isLoading: false,
    isSubmitting: false,
    isSuccess: false,
    isFailure: false
  );

  factory LoginState.isLoading() => LoginState(
    isEmailValid: true,
    isPasswordValid: true,
    isLoading: true,
    isSubmitting: true,
    isSuccess: false,
    isFailure: false
  );

  factory LoginState.isFailure() => LoginState(
    isEmailValid: true,
    isPasswordValid: true,
    isLoading: false,
    isSubmitting: false,
    isSuccess: false,
    isFailure: true
  );

  factory LoginState.isSuccess() => LoginState(
    isEmailValid: true,
    isPasswordValid: true,
    isLoading: false,
    isSubmitting: false,
    isSuccess: true,
    isFailure: false
  );

  LoginState update({
    bool isEmailValid,
    bool isPasswordValid
  }) => copyWith(
    isEmailValid: isEmailValid,
    isPasswordValid: isPasswordValid,
    isSubmitting: false,
    isSuccess: false,
    isFailure: false
  );

  LoginState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isLoading,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure
  }) => LoginState(
    isEmailValid: isEmailValid ?? this.isEmailValid,
    isPasswordValid: isPasswordValid ?? this.isPasswordValid,
    isLoading: isLoading ?? this.isLoading,
    isSubmitting: isSubmitting ?? this.isSubmitting,
    isSuccess: isSuccess ?? this.isSuccess,
    isFailure: isFailure ?? this.isFailure
  );

  @override
  String toString() => '''LoginState {
    isEmailValid: $isEmailValid,
    isPasswordValid: $isPasswordValid,
    isLoading: $isLoading,
    isSubmitting: $isSubmitting,
    isSuccess: $isSuccess,
    isFailure: $isFailure
  }''';
}