import 'package:meta/meta.dart';

@immutable
class RegisterState {

  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isLoading;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;

  RegisterState({
    @required this.isEmailValid, 
    @required this.isPasswordValid, 
    @required this.isLoading, 
    @required this.isSubmitting, 
    @required this.isSuccess, 
    @required this.isFailure});

  factory RegisterState.empty() => RegisterState(
    isEmailValid: true,
    isPasswordValid: true,
    isLoading: false,
    isSubmitting: false,
    isSuccess: false,
    isFailure: false
  );

  factory RegisterState.loading() => RegisterState(
    isEmailValid: true,
    isPasswordValid: true,
    isLoading: true,
    isSubmitting: false,
    isSuccess: false,
    isFailure: false
  );

  factory RegisterState.success() => RegisterState(
    isEmailValid: true,
    isPasswordValid: true,
    isLoading: false,
    isSubmitting: false,
    isSuccess: true,
    isFailure: false
  );

  factory RegisterState.failure() => RegisterState(
    isEmailValid: true,
    isPasswordValid: true,
    isLoading: false,
    isSubmitting: false,
    isSuccess: false,
    isFailure: true
  );

  RegisterState update({
    bool isEmailValid,
    bool isPasswordValid
  }) => copyWith(
    isEmailValid: isEmailValid,
    isPasswordValid: isPasswordValid,
    isLoading: false,
    isSubmitting: false,
    isSuccess: false,
    isFailure: false
  );

  RegisterState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isLoading,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure
  }) {

    return RegisterState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure
    );
  }

  @override
  String toString() => '''RegisterState {
    isEmailValid: $isEmailValid,
    ispasswordValid: $isPasswordValid,
    isLoading: $isLoading,
    isSubmitting: $isSubmitting,
    isSuccess: $isSuccess,
    isFailure: $isFailure
  }''';
}